output "name" {
  description = "Name of the Cloud NAT"
  value       = google_compute_router_nat.this.name
}

output "id" {
  description = "ID of the Cloud NAT"
  value       = google_compute_router_nat.this.id
}
