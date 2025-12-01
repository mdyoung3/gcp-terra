output "describe_ssh" {
  description = "Shows ssh details."
  value = "gcloud compute ssh --zone ${terraform.workspace == "default" ? var.gcp_zone_1 : var.gcp_zone_2} ${google_compute_instance.jb-website.name} --project ${ var.project_name }"
}
