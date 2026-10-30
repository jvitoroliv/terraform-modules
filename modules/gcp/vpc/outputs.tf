output "name" {
  description = "Name of the VPC network"
  value       = google_compute_network.this.name
}

output "id" {
  description = "ID of the VPC network"
  value       = google_compute_network.this.id
}

output "self_link" {
  description = "Self link of the VPC network"
  value       = google_compute_network.this.self_link
}

output "gateway_ipv4" {
  description = "Gateway IPv4 address"
  value       = google_compute_network.this.gateway_ipv4
}
