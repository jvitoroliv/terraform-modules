locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

resource "aws_cloudwatch_log_group" "this" {
  name              = var.name
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id != "" ? var.kms_key_id : null
  log_group_class   = var.log_group_class

  tags = local.merged_tags

  lifecycle {
    prevent_destroy = false
  }
}