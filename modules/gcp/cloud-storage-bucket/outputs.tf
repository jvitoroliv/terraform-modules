output "name" {
  description = "Name of the bucket"
  value       = google_storage_bucket.this.name
}

output "id" {
  description = "ID of the bucket"
  value       = google_storage_bucket.this.id
}

output "self_link" {
  description = "Self link of the bucket"
  value       = google_storage_bucket.this.self_link
}

output "url" {
  description = "URL of the bucket"
  value       = google_storage_bucket.this.url
}
