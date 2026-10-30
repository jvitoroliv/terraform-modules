output "name" {
  description = "Name of the repository"
  value       = google_artifact_registry_repository.this.name
}

output "id" {
  description = "ID of the repository"
  value       = google_artifact_registry_repository.this.id
}
