terraform {
  backend "gcs" {
    bucket = "69f0a71e79402607-terraform-remote-backend-dev"
    prefix = "jellobelt/state"

    # Optional settings
  }
}
