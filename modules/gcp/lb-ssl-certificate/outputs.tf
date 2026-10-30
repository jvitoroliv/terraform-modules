output "name" {
  description = "Name of the SSL certificate"
  value       = google_compute_managed_ssl_certificate.this.name
}

output "id" {
  description = "ID of the SSL certificate"
  value       = google_compute_managed_ssl_certificate.this.id
}

output "self_link" {
  description = "Self link of the SSL certificate"
  value       = google_compute_managed_ssl_certificate.this.self_link
}

output "certificate_id" {
  description = "Unique identifier for the SSL certificate"
  value       = google_compute_managed_ssl_certificate.this.certificate_id
}

output "creation_timestamp" {
  description = "Creation timestamp"
  value       = google_compute_managed_ssl_certificate.this.creation_timestamp
}

output "expire_time" {
  description = "Expiration time of the certificate"
  value       = google_compute_managed_ssl_certificate.this.expire_time
}

output "subject_alternative_names" {
  description = "List of domains covered by the certificate"
  value       = google_compute_managed_ssl_certificate.this.subject_alternative_names
}
