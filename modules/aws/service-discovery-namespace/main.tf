locals {
  # Generate description if not provided
  namespace_description = var.description != "" ? var.description : "Service discovery namespace for ${var.name}"
}

resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = var.name
  description = local.namespace_description
  vpc         = var.vpc_id

  tags = var.tags
}