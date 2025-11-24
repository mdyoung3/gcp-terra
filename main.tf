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
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "random_id" "default" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  name     = "${random_id.default.hex}-terraform-remote-backend"
  location = "US"

  force_destroy               = false
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

resource "local_file" "default" {
  file_permission = "0644"
  filename        = "${path.module}/backend.tf"

  content = templatefile("./templates/backend.tf.tpl", {
    bucket_name = google_storage_bucket.default.name
    prefix         = "terraform/state"
    encryption_key = ""
  })
}

locals {
  ssh_public_key = file(var.ssh_pub_key)
}

resource "google_compute_instance" "website" {
  name         = "vpc-instance"
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

  # Add SSH key to instance
  metadata = {
    ssh-keys = "your-username:${local.ssh_public_key}"
  }

  tags = ["ssh-enabled"]
}


# Firewall rule for SSH
resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.allowed_ssh_ips]  # Or restrict to your IP
  target_tags   = ["ssh-enabled"]
}

# Output the IP
output "instance_ip" {
  value = google_compute_instance.web.network_interface[0].access_config[0].nat_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/gcp_terraform_key your-username@${google_compute_instance.web.network_interface[0].access_config[0].nat_ip}"
}
