output "name" {
  description = "Name of the firewall rule"
  value       = google_compute_firewall.this.name
}

output "id" {
  description = "ID of the firewall rule"
  value       = google_compute_firewall.this.id
}

output "self_link" {
  description = "Self link of the firewall rule"
  value       = google_compute_firewall.this.self_link
}
