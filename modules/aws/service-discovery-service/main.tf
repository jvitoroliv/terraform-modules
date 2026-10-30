locals {
  # Generate description if not provided
  service_description = var.description != "" ? var.description : "Service discovery service for ${var.name}"
}

resource "aws_service_discovery_service" "this" {
  name = var.name
  description = local.service_description

  dns_config {
    namespace_id = var.namespace_id

    dns_records {
      ttl  = var.dns_ttl
      type = var.dns_type
    }

    routing_policy = var.routing_policy
  }

  # Optional health check configuration
  dynamic "health_check_custom_config" {
    for_each = var.health_check_custom_config != null ? [var.health_check_custom_config] : []
    content {
      failure_threshold = health_check_custom_config.value.failure_threshold
    }
  }

  tags = var.tags
}