output "name" {
  description = "Name of the subnet"
  value       = google_compute_subnetwork.this.name
}

output "id" {
  description = "ID of the subnet"
  value       = google_compute_subnetwork.this.id
}

output "self_link" {
  description = "Self link of the subnet"
  value       = google_compute_subnetwork.this.self_link
}

output "gateway_address" {
  description = "Gateway address of the subnet"
  value       = google_compute_subnetwork.this.gateway_address
}

output "ip_cidr_range" {
  description = "IP CIDR range of the subnet"
  value       = google_compute_subnetwork.this.ip_cidr_range
}
