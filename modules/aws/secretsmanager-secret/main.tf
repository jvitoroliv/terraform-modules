locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

resource "aws_secretsmanager_secret" "this" {
  name                    = var.name
  description             = var.description
  kms_key_id              = var.kms_key_id != "" ? var.kms_key_id : null
  recovery_window_in_days = var.recovery_window_in_days
  tags                    = local.merged_tags
}

# Create the initial version only when a value is provided.
resource "aws_secretsmanager_secret_version" "this" {
  count         = var.secret_string != "" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string
}

# Optional resource policy
resource "aws_secretsmanager_secret_policy" "this" {
  count      = var.resource_policy_json != "" ? 1 : 0
  secret_arn = aws_secretsmanager_secret.this.arn
  policy     = var.resource_policy_json
}