output "bucket_name" {
  description = "Provides name of storage bucket where state file will be housed."
  value = google_storage_bucket.default.name
}

output "bucket_url" {
  description = "Provides easy access link."
  value = google_storage_bucket.default.url
}

output "bucket_self_link" {
  description = "Provides self link to storage bucket for state file."
  value = google_storage_bucket.default.self_link
}

output "random_id" {
  value = "This is the id (prefix) for this bucket: ${random_id.default.hex}"
}
