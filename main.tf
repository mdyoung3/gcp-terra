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

module "state_file_bucket" {
  source = "./modules/gcs_backend"

  backend_file_path = path.module
  bucket_location   = "US"
  state_prefix      = "jellobelt/state"
  template_path     = "${path.module}/templates/backend.tf.tpl"

  lifecycle_rules = [
    {
      action = "Delete"
      age    = 365 # Delete old versions after 1 year
    }
  ]

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

  tags = ["ssh-enabled"]
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-enabled"]
}
