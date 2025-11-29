terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}
resource "random_id" "default" {
  byte_length = var.ran_id_length
}

resource "google_storage_bucket" "default" {
  name     = "${random_id.default.hex}-terraform-remote-backend-${terraform.workspace}"
  location = var.bucket_location
  force_destroy               = var.force_destroy
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  versioning {
    enabled = var.versioning_enabled
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type = lifecycle_rule.value.action
      }
      condition {
        age = lifecycle_rule.value.age
      }
    }
  }
}

resource "local_file" "backend_config" {
  count = var.generate_backend_file ? 1 : 0

  file_permission = "0644"
  filename = "${var.backend_file_path}/backend.tf.tpl"

  content = templatefile("${var.template_path}", {
    bucket_name = google_storage_bucket.default.name
    prefix = var.state_prefix
    encryption_key = var.encryption_key
  })
}
