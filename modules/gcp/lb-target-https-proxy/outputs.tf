output "name" {
  description = "Name of the target HTTPS proxy"
  value       = google_compute_target_https_proxy.this.name
}

output "id" {
  description = "ID of the target HTTPS proxy"
  value       = google_compute_target_https_proxy.this.id
}

output "self_link" {
  description = "Self link of the target HTTPS proxy"
  value       = google_compute_target_https_proxy.this.self_link
}

output "proxy_id" {
  description = "Unique identifier for the target HTTPS proxy"
  value       = google_compute_target_https_proxy.this.proxy_id
}

output "creation_timestamp" {
  description = "Creation timestamp"
  value       = google_compute_target_https_proxy.this.creation_timestamp
}
