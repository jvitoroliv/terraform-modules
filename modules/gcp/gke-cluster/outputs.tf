output "name" {
  description = "Name of the GKE cluster"
  value       = google_container_cluster.this.name
}

output "id" {
  description = "ID of the GKE cluster"
  value       = google_container_cluster.this.id
}

output "endpoint" {
  description = "Endpoint of the GKE cluster"
  value       = google_container_cluster.this.endpoint
}

output "master_version" {
  description = "Master version of the GKE cluster"
  value       = google_container_cluster.this.master_version
}

output "cluster_ca_certificate" {
  description = "Cluster CA certificate (base64 encoded)"
  value       = google_container_cluster.this.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "location" {
  description = "Location of the GKE cluster"
  value       = google_container_cluster.this.location
}
