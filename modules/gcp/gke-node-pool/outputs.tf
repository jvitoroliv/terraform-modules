output "name" {
  description = "Name of the node pool"
  value       = google_container_node_pool.this.name
}

output "id" {
  description = "ID of the node pool"
  value       = google_container_node_pool.this.id
}
