resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn
  priority     = var.priority

  # Condition block - only one type can be specified
  dynamic "condition" {
    for_each = var.condition.host_header != null ? [var.condition.host_header] : []
    content {
      host_header {
        values = condition.value.values
      }
    }
  }

  dynamic "condition" {
    for_each = var.condition.path_pattern != null ? [var.condition.path_pattern] : []
    content {
      path_pattern {
        values = condition.value.values
      }
    }
  }

  dynamic "condition" {
    for_each = var.condition.http_header != null ? [var.condition.http_header] : []
    content {
      http_header {
        http_header_name = condition.value.name
        values           = condition.value.values
      }
    }
  }

  dynamic "condition" {
    for_each = var.condition.http_request_method != null ? [var.condition.http_request_method] : []
    content {
      http_request_method {
        values = condition.value.values
      }
    }
  }

  dynamic "condition" {
    for_each = var.condition.query_string != null ? var.condition.query_string : []
    content {
      query_string {
        key   = condition.value.key
        value = condition.value.value
      }
    }
  }

  dynamic "condition" {
    for_each = var.condition.source_ip != null ? [var.condition.source_ip] : []
    content {
      source_ip {
        values = condition.value.values
      }
    }
  }

  # Action block
  action {
    type             = var.action.type
    target_group_arn = var.action.target_group_arn

    dynamic "redirect" {
      for_each = var.action.redirect != null ? [var.action.redirect] : []
      content {
        host        = redirect.value.host
        path        = redirect.value.path
        port        = redirect.value.port
        protocol    = redirect.value.protocol
        query       = redirect.value.query
        status_code = redirect.value.status_code
      }
    }

    dynamic "fixed_response" {
      for_each = var.action.fixed_response != null ? [var.action.fixed_response] : []
      content {
        content_type = fixed_response.value.content_type
        message_body = fixed_response.value.message_body
        status_code  = fixed_response.value.status_code
      }
    }

    dynamic "forward" {
      for_each = var.action.forward != null ? [var.action.forward] : []
      content {
        dynamic "target_group" {
          for_each = forward.value.target_groups
          content {
            arn    = target_group.value.arn
            weight = target_group.value.weight
          }
        }

        dynamic "stickiness" {
          for_each = forward.value.stickiness != null ? [forward.value.stickiness] : []
          content {
            enabled  = stickiness.value.enabled
            duration = stickiness.value.duration
          }
        }
      }
    }
  }

  tags = var.tags
}