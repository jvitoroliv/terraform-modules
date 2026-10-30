resource "google_compute_health_check" "this" {
  name        = var.name
  project     = var.project
  description = var.description

  check_interval_sec  = var.check_interval_sec
  timeout_sec         = var.timeout_sec
  healthy_threshold   = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold

  dynamic "tcp_health_check" {
    for_each = var.type == "TCP" ? [1] : []
    content {
      port               = var.port
      port_name          = var.port_name
      port_specification = var.port_specification
      proxy_header       = var.proxy_header
      request            = var.tcp_request
      response           = var.tcp_response
    }
  }

  dynamic "http_health_check" {
    for_each = var.type == "HTTP" ? [1] : []
    content {
      port               = var.port
      port_name          = var.port_name
      port_specification = var.port_specification
      proxy_header       = var.proxy_header
      host               = var.http_host
      request_path       = var.http_request_path
      response           = var.http_response
    }
  }

  dynamic "https_health_check" {
    for_each = var.type == "HTTPS" ? [1] : []
    content {
      port               = var.port
      port_name          = var.port_name
      port_specification = var.port_specification
      proxy_header       = var.proxy_header
      host               = var.http_host
      request_path       = var.http_request_path
      response           = var.http_response
    }
  }

  dynamic "grpc_health_check" {
    for_each = var.type == "GRPC" ? [1] : []
    content {
      port               = var.port
      port_name          = var.port_name
      port_specification = var.port_specification
      grpc_service_name  = var.grpc_service_name
    }
  }

  dynamic "ssl_health_check" {
    for_each = var.type == "SSL" ? [1] : []
    content {
      port               = var.port
      port_name          = var.port_name
      port_specification = var.port_specification
      proxy_header       = var.proxy_header
      request            = var.tcp_request
      response           = var.tcp_response
    }
  }

  log_config {
    enable = var.log_config_enable
  }
}
