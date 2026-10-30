resource "aws_launch_template" "this" {
  name_prefix   = var.name_prefix
  name          = var.name
  description   = var.description
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = var.user_data_base64

  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile_arn != "" ? [1] : []
    content {
      arn = var.iam_instance_profile_arn
    }
  }

  vpc_security_group_ids = var.security_group_ids

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name = block_device_mappings.value.device_name

      dynamic "ebs" {
        for_each = lookup(block_device_mappings.value, "ebs", null) != null ? [block_device_mappings.value.ebs] : []
        content {
          delete_on_termination = lookup(ebs.value, "delete_on_termination", true)
          encrypted             = lookup(ebs.value, "encrypted", true)
          volume_size           = lookup(ebs.value, "volume_size", 30)
          volume_type           = lookup(ebs.value, "volume_type", "gp3")
          iops                  = lookup(ebs.value, "iops", null)
          throughput            = lookup(ebs.value, "throughput", null)
        }
      }
    }
  }

  dynamic "network_interfaces" {
    for_each = var.network_interfaces
    content {
      associate_public_ip_address = lookup(network_interfaces.value, "associate_public_ip_address", false)
      delete_on_termination       = lookup(network_interfaces.value, "delete_on_termination", true)
      device_index                = lookup(network_interfaces.value, "device_index", 0)
      security_groups             = lookup(network_interfaces.value, "security_groups", [])
    }
  }

  monitoring {
    enabled = var.enable_monitoring
  }

  metadata_options {
    http_endpoint               = var.metadata_options.http_endpoint
    http_tokens                 = var.metadata_options.http_tokens
    http_put_response_hop_limit = var.metadata_options.http_put_response_hop_limit
    instance_metadata_tags      = var.metadata_options.instance_metadata_tags
  }

  tag_specifications {
    resource_type = "instance"
    tags          = merge(var.tags, { Name = var.name })
  }

  tag_specifications {
    resource_type = "volume"
    tags          = merge(var.tags, { Name = var.name })
  }

  tags = var.tags

  # Set $Latest as default version
  update_default_version = true
}