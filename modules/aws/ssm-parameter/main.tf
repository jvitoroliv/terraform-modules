locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

resource "aws_ssm_parameter" "this" {
  name            = var.name
  type            = var.type
  value           = var.value != "" ? var.value : null
  overwrite       = var.overwrite
  description     = var.description
  tier            = var.tier
  allowed_pattern = var.allowed_pattern != "" ? var.allowed_pattern : null
  key_id          = var.type == "SecureString" && var.kms_key_id != "" ? var.kms_key_id : null

  tags = local.merged_tags
}