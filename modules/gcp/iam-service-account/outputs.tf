output "email" {
  description = "Email of the service account"
  value       = google_service_account.this.email
}

output "name" {
  description = "Name of the service account"
  value       = google_service_account.this.name
}

output "unique_id" {
  description = "Unique ID of the service account"
  value       = google_service_account.this.unique_id
}

output "id" {
  description = "ID of the service account"
  value       = google_service_account.this.id
}
