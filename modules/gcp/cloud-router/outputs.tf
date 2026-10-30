output "name" {
  description = "Name of the Cloud Router"
  value       = google_compute_router.this.name
}

output "id" {
  description = "ID of the Cloud Router"
  value       = google_compute_router.this.id
}

output "self_link" {
  description = "Self link of the Cloud Router"
  value       = google_compute_router.this.self_link
}
