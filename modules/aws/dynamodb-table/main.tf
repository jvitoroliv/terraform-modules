locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

resource "aws_dynamodb_table" "this" {
  name         = var.name
  billing_mode = var.billing_mode

  # Provisioned capacity only when requested
  read_capacity  = var.billing_mode == "PROVISIONED" ? var.read_capacity  : null
  write_capacity = var.billing_mode == "PROVISIONED" ? var.write_capacity : null

  hash_key  = var.hash_key
  range_key = var.range_key != "" ? var.range_key : null

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name               = global_secondary_index.value.name
      hash_key           = global_secondary_index.value.hash_key
      range_key          = try(global_secondary_index.value.range_key, null)
      projection_type    = global_secondary_index.value.projection_type
      non_key_attributes = try(global_secondary_index.value.non_key_attributes, null)

      read_capacity  = var.billing_mode == "PROVISIONED" ? try(global_secondary_index.value.read_capacity, 5)  : null
      write_capacity = var.billing_mode == "PROVISIONED" ? try(global_secondary_index.value.write_capacity, 5) : null
    }
  }

  dynamic "ttl" {
    for_each = var.ttl != null ? [var.ttl] : []
    content {
      attribute_name = ttl.value.attribute_name
      enabled        = ttl.value.enabled
    }
  }

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_enabled ? var.stream_view_type : null

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  server_side_encryption {
    enabled     = var.server_side_encryption
    kms_key_arn = var.kms_key_arn != "" ? var.kms_key_arn : null
  }

  tags = local.merged_tags
}