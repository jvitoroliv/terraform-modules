output "name" {
  description = "Name of the URL map"
  value       = google_compute_url_map.this.name
}

output "id" {
  description = "ID of the URL map"
  value       = google_compute_url_map.this.id
}

output "self_link" {
  description = "Self link of the URL map"
  value       = google_compute_url_map.this.self_link
}

output "fingerprint" {
  description = "Fingerprint of the URL map"
  value       = google_compute_url_map.this.fingerprint
}

output "map_id" {
  description = "Unique identifier for the URL map"
  value       = google_compute_url_map.this.map_id
}
