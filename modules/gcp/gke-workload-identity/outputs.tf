output "service_account_email" {
  description = "Email of the created service account"
  value       = google_service_account.this.email
}

output "service_account_name" {
  description = "Name of the created service account"
  value       = google_service_account.this.name
}

output "service_account_id" {
  description = "ID of the created service account"
  value       = google_service_account.this.id
}

output "service_account_unique_id" {
  description = "Unique ID of the service account"
  value       = google_service_account.this.unique_id
}

output "workload_identity_member" {
  description = "Workload Identity member string"
  value       = "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace}/${var.ksa_name}]"
}
