output "name" {
  description = "Name of the secret version"
  value       = google_secret_manager_secret_version.this.name
}

output "id" {
  description = "ID of the secret version"
  value       = google_secret_manager_secret_version.this.id
}

output "version" {
  description = "Version number"
  value       = google_secret_manager_secret_version.this.version
}

output "create_time" {
  description = "Creation timestamp"
  value       = google_secret_manager_secret_version.this.create_time
}

output "destroy_time" {
  description = "Destroy timestamp (if applicable)"
  value       = google_secret_manager_secret_version.this.destroy_time
}
