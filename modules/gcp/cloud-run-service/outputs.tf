output "name" {
  description = "Name of the Cloud Run service"
  value       = google_cloud_run_v2_service.this.name
}

output "id" {
  description = "ID of the Cloud Run service"
  value       = google_cloud_run_v2_service.this.id
}

output "uri" {
  description = "URI of the Cloud Run service"
  value       = google_cloud_run_v2_service.this.uri
}

output "latest_ready_revision" {
  description = "Latest ready revision name"
  value       = google_cloud_run_v2_service.this.latest_ready_revision
}
