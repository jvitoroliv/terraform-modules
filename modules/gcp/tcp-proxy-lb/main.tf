locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

# Reserve a global static IP address
resource "google_compute_global_address" "this" {
  count = var.create_ip_address ? 1 : 0

  name         = "${var.name}-ip"
  project      = var.project
  description  = "Static IP for ${var.name} TCP Proxy LB"
  address_type = "EXTERNAL"
  ip_version   = var.ip_version
}

# Backend service for TCP proxy
resource "google_compute_backend_service" "this" {
  name        = "${var.name}-backend"
  project     = var.project
  description = var.description

  protocol                        = "TCP"
  port_name                       = var.port_name
  timeout_sec                     = var.timeout_sec
  connection_draining_timeout_sec = var.connection_draining_timeout_sec
  load_balancing_scheme           = "EXTERNAL"
  session_affinity                = var.session_affinity

  health_checks = var.health_checks

  dynamic "backend" {
    for_each = var.backends
    content {
      group                 = backend.value.group
      balancing_mode        = try(backend.value.balancing_mode, "UTILIZATION")
      capacity_scaler       = try(backend.value.capacity_scaler, 1.0)
      max_utilization       = try(backend.value.max_utilization, 0.8)
      max_connections       = try(backend.value.max_connections, null)
      max_rate              = try(backend.value.max_rate, null)
      max_rate_per_instance = try(backend.value.max_rate_per_instance, null)
    }
  }

  dynamic "log_config" {
    for_each = var.enable_logging ? [1] : []
    content {
      enable      = true
      sample_rate = var.log_sample_rate
    }
  }
}

# TCP Proxy target
resource "google_compute_target_tcp_proxy" "this" {
  name            = "${var.name}-proxy"
  project         = var.project
  description     = "TCP Proxy for ${var.name}"
  backend_service = google_compute_backend_service.this.self_link
  proxy_header    = var.proxy_header
}

# SSL Proxy target (for TLS termination - alternative to TCP proxy)
resource "google_compute_target_ssl_proxy" "this" {
  count = var.enable_ssl ? 1 : 0

  name             = "${var.name}-ssl-proxy"
  project          = var.project
  description      = "SSL Proxy for ${var.name}"
  backend_service  = google_compute_backend_service.this.self_link
  ssl_certificates = var.ssl_certificates
  ssl_policy       = var.ssl_policy
  proxy_header     = var.proxy_header
}

# Forwarding rule for TCP (non-SSL)
resource "google_compute_global_forwarding_rule" "tcp" {
  count = var.enable_ssl ? 0 : 1

  name        = "${var.name}-tcp-rule"
  project     = var.project
  description = "TCP forwarding rule for ${var.name}"

  target     = google_compute_target_tcp_proxy.this.self_link
  port_range = var.port_range
  ip_address = var.create_ip_address ? google_compute_global_address.this[0].address : var.ip_address

  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"

  labels = local.merged_labels
}

# Forwarding rule for SSL/TLS
resource "google_compute_global_forwarding_rule" "ssl" {
  count = var.enable_ssl ? 1 : 0

  name        = "${var.name}-ssl-rule"
  project     = var.project
  description = "SSL forwarding rule for ${var.name}"

  target     = google_compute_target_ssl_proxy.this[0].self_link
  port_range = var.port_range
  ip_address = var.create_ip_address ? google_compute_global_address.this[0].address : var.ip_address

  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"

  labels = local.merged_labels
}
