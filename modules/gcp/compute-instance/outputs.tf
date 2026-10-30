output "name" {
  description = "Name of the compute instance"
  value       = google_compute_instance.this.name
}

output "id" {
  description = "ID of the compute instance"
  value       = google_compute_instance.this.id
}

output "self_link" {
  description = "Self link of the compute instance"
  value       = google_compute_instance.this.self_link
}

output "instance_id" {
  description = "Server-assigned unique identifier"
  value       = google_compute_instance.this.instance_id
}

output "internal_ip" {
  description = "Internal IP address"
  value       = google_compute_instance.this.network_interface[0].network_ip
}

output "external_ip" {
  description = "External IP address (if assigned)"
  value       = try(google_compute_instance.this.network_interface[0].access_config[0].nat_ip, null)
}

output "zone" {
  description = "Zone of the instance"
  value       = google_compute_instance.this.zone
}
