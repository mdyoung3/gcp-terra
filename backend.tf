terraform {
    backend "gcs" {
        bucket = "effa0732c6b5153f-terraform-backend"
        prefix = "terraform/state"

        # Optional settings
            }
}
