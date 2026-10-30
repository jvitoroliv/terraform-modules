locals {
  is_https = var.protocol == "HTTPS"
  da       = var.default_action
}

# Base listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol

  certificate_arn = local.is_https && var.certificate_arn != "" ? var.certificate_arn : null
  ssl_policy      = local.is_https ? var.ssl_policy : null

  dynamic "default_action" {
    for_each = [1]
    content {
      type = local.da.type

      # ---- FORWARD (um único TG) ----
      # Use target_group_arn attribute directly to avoid provider crashes with unknown values
      target_group_arn = local.da.type == "forward" && try(local.da.target_group_arn, "") != "" ? local.da.target_group_arn : null

      # ---- REDIRECT ----
      dynamic "redirect" {
        for_each = local.da.type == "redirect" && can(local.da.redirect) ? [1] : []
        content {
          port        = local.da.redirect.port
          protocol    = local.da.redirect.protocol
          status_code = local.da.redirect.status_code
          host        = try(local.da.redirect.host, null)
          path        = try(local.da.redirect.path, null)
          query       = try(local.da.redirect.query, null)
        }
      }

      # ---- FIXED RESPONSE ----
      dynamic "fixed_response" {
        for_each = local.da.type == "fixed-response" && can(local.da.fixed_response) ? [1] : []
        content {
          content_type = local.da.fixed_response.content_type
          message_body = try(local.da.fixed_response.message_body, null)
          status_code  = local.da.fixed_response.status_code
        }
      }
    }
  }
}

# Optional rules
resource "aws_lb_listener_rule" "this" {
  for_each = { for r in var.rules : r.priority => r }

  listener_arn = aws_lb_listener.this.arn
  priority     = each.key

  dynamic "condition" {
    for_each = try(each.value.host_headers, null) != null ? [1] : []
    content {
      host_header {
        values = each.value.host_headers
      }
    }
  }

  dynamic "condition" {
    for_each = try(each.value.path_patterns, null) != null ? [1] : []
    content {
      path_pattern {
        values = each.value.path_patterns
      }
    }
  }

  dynamic "condition" {
    for_each = try(each.value.http_headers, null) != null ? each.value.http_headers : []
    content {
      http_header {
        http_header_name = condition.value.name
        values           = condition.value.values
      }
    }
  }

  action {
    type             = "forward"
    target_group_arn = each.value.target_group_arn
  }

  tags = var.tags
}
