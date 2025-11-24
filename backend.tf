terraform {
    backend "gcs" {
        bucket = "effa0732c6b5153f-terraform-remote-backend"
        prefix = "terraform/state"

        # Optional settings
            }
}
