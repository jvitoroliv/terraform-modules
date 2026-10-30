output "name" {
  description = "Name of the global forwarding rule"
  value       = google_compute_global_forwarding_rule.this.name
}

output "id" {
  description = "ID of the global forwarding rule"
  value       = google_compute_global_forwarding_rule.this.id
}

output "self_link" {
  description = "Self link of the global forwarding rule"
  value       = google_compute_global_forwarding_rule.this.self_link
}

output "ip_address" {
  description = "IP address assigned to the forwarding rule"
  value       = google_compute_global_forwarding_rule.this.ip_address
}

output "psc_connection_id" {
  description = "PSC connection ID"
  value       = google_compute_global_forwarding_rule.this.psc_connection_id
}

output "base_forwarding_rule" {
  description = "Base forwarding rule URL"
  value       = google_compute_global_forwarding_rule.this.base_forwarding_rule
}

output "label_fingerprint" {
  description = "Label fingerprint for conditional updates"
  value       = google_compute_global_forwarding_rule.this.label_fingerprint
}
