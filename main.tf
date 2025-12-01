terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.12.0"
    }
  }
}

provider "google" {
  project = var.project_name
  region  = terraform.workspace == "default" ? var.gcp_region_1 : var.gcp_region_2
  zone    = terraform.workspace == "default" ? var.gcp_zone_1 : var.gcp_zone_2
}

resource "random_id" "default" {
  byte_length = 8
}

resource "google_storage_bucket" "terraform_state" {
  name     = "${random_id.default.hex}-terraform-backend"
  location = "US"

  force_destroy               = false
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

resource "local_file" "backend_config" {
  file_permission = "0644"
  filename        = "./backend.tf"

  content = templatefile("./templates/backend.tf.tpl", {
    bucket_name = google_storage_bucket.terraform_state.name
    prefix      = "terraform/state"
    encryption_key = ""
  })
}

resource "google_compute_instance" "jb-website" {
  name         = "jb-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = var.machine_image
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {}
  }

  # metadata_startup_script = templatefile("templates/startup_script.tpl", { environment = var.environment })

  tags = ["ssh-enabled"]
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_ip_ranges
  target_tags   = ["ssh-enabled"]
}

resource "google_compute_firewall" "http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}
