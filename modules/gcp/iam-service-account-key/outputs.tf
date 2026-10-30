output "name" {
  description = "Name of the service account key"
  value       = google_service_account_key.this.name
}

output "id" {
  description = "ID of the service account key"
  value       = google_service_account_key.this.id
}

output "private_key" {
  description = "Private key in base64 format (sensitive)"
  value       = google_service_account_key.this.private_key
  sensitive   = true
}

output "public_key" {
  description = "Public key data in base64 format"
  value       = google_service_account_key.this.public_key
}

output "valid_after" {
  description = "Key valid after timestamp"
  value       = google_service_account_key.this.valid_after
}

output "valid_before" {
  description = "Key valid before timestamp"
  value       = google_service_account_key.this.valid_before
}
