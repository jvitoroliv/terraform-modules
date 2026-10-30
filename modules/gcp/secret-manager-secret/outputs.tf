output "name" {
  description = "Name of the secret"
  value       = google_secret_manager_secret.this.name
}

output "id" {
  description = "ID of the secret"
  value       = google_secret_manager_secret.this.id
}

output "secret_id" {
  description = "Secret ID"
  value       = google_secret_manager_secret.this.secret_id
}

output "create_time" {
  description = "Creation timestamp"
  value       = google_secret_manager_secret.this.create_time
}
