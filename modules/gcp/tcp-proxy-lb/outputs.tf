output "ip_address" {
  description = "IP address of the load balancer"
  value       = var.create_ip_address ? google_compute_global_address.this[0].address : var.ip_address
}

output "ip_address_self_link" {
  description = "Self link of the IP address resource"
  value       = var.create_ip_address ? google_compute_global_address.this[0].self_link : null
}

output "backend_service_id" {
  description = "ID of the backend service"
  value       = google_compute_backend_service.this.id
}

output "backend_service_self_link" {
  description = "Self link of the backend service"
  value       = google_compute_backend_service.this.self_link
}

output "tcp_proxy_id" {
  description = "ID of the TCP proxy"
  value       = google_compute_target_tcp_proxy.this.id
}

output "ssl_proxy_id" {
  description = "ID of the SSL proxy (if enabled)"
  value       = var.enable_ssl ? google_compute_target_ssl_proxy.this[0].id : null
}

output "forwarding_rule_id" {
  description = "ID of the forwarding rule"
  value       = var.enable_ssl ? google_compute_global_forwarding_rule.ssl[0].id : google_compute_global_forwarding_rule.tcp[0].id
}

output "forwarding_rule_self_link" {
  description = "Self link of the forwarding rule"
  value       = var.enable_ssl ? google_compute_global_forwarding_rule.ssl[0].self_link : google_compute_global_forwarding_rule.tcp[0].self_link
}
