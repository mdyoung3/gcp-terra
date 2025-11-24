terraform {
    backend "gcs" {
        bucket = "${bucket_name}"
        prefix = "${prefix}"

        # Optional settings
        %{ if encryption_key != "" ~}
        encryption_key = "${encryption_key}"
        %{ endif ~}
    }
}
