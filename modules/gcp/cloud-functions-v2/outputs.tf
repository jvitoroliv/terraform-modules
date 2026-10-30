output "name" {
  description = "Name of the Cloud Function"
  value       = google_cloudfunctions2_function.this.name
}

output "id" {
  description = "ID of the Cloud Function"
  value       = google_cloudfunctions2_function.this.id
}

output "url" {
  description = "URL of the Cloud Function"
  value       = google_cloudfunctions2_function.this.service_config[0].uri
}

output "state" {
  description = "Current state of the function"
  value       = google_cloudfunctions2_function.this.state
}

output "environment" {
  description = "Environment of the function"
  value       = google_cloudfunctions2_function.this.environment
}

