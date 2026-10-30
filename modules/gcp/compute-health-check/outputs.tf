output "name" {
  description = "Name of the health check"
  value       = google_compute_health_check.this.name
}

output "id" {
  description = "ID of the health check"
  value       = google_compute_health_check.this.id
}

output "self_link" {
  description = "Self link of the health check"
  value       = google_compute_health_check.this.self_link
}

output "type" {
  description = "Type of health check"
  value       = google_compute_health_check.this.type
}
