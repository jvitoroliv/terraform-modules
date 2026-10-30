locals {
  merged_tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

resource "aws_lb" "this" {
  name                       = var.name
  internal                   = var.internal
  load_balancer_type         = "application"
  subnets                    = var.subnets
  security_groups            = var.security_group_ids
  idle_timeout               = var.idle_timeout
  enable_http2               = var.enable_http2
  drop_invalid_header_fields = var.drop_invalid_header_fields
  ip_address_type            = var.ip_address_type
  desync_mitigation_mode     = var.desync_mitigation_mode
  enable_deletion_protection = var.deletion_protection

  dynamic "access_logs" {
    for_each = var.access_logs != null && var.access_logs.enabled ? [var.access_logs] : []
    content {
      bucket  = access_logs.value.bucket
      prefix  = try(access_logs.value.prefix, "")
      enabled = true
    }
  }

  tags = local.merged_tags
}