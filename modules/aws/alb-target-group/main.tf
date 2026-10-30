locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

resource "aws_lb_target_group" "this" {
  name             = var.name
  vpc_id           = var.vpc_id
  port             = var.port
  protocol         = var.protocol
  target_type      = var.target_type
  deregistration_delay = var.deregistration_delay

  # Only applicable to HTTP/HTTPS
  protocol_version = var.protocol_version

  health_check {
    enabled             = true
    path                = try(var.health_check.path, "/")
    healthy_threshold   = try(var.health_check.healthy_threshold, 2)
    unhealthy_threshold = try(var.health_check.unhealthy_threshold, 3)
    interval            = try(var.health_check.interval, 15)
    timeout             = try(var.health_check.timeout, 5)
    matcher             = try(var.health_check.matcher, "200-399")
    port                = try(var.health_check.port, "traffic-port")
    protocol            = try(var.health_check.protocol, "HTTP")
  }

  dynamic "stickiness" {
    for_each = var.stickiness != null ? [var.stickiness] : []
    content {
      enabled         = stickiness.value.enabled
      type            = stickiness.value.type
      cookie_duration = try(stickiness.value.cookie_duration, null)
      cookie_name     = try(stickiness.value.cookie_name, null)
    }
  }

  tags = local.merged_tags
}