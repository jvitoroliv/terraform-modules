locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

# Build a default trust policy only if the user did not pass a full JSON
data "aws_iam_policy_document" "assume_role" {
  count = var.assume_role_policy == "" && var.assume_role_principal != "" ? 1 : 0
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = [var.assume_role_principal]
    }
  }
}

resource "aws_iam_role" "this" {
  name                 = var.name
  path                 = var.path
  description          = var.description
  assume_role_policy   = var.assume_role_policy != "" ? var.assume_role_policy : (var.assume_role_principal != "" ? data.aws_iam_policy_document.assume_role[0].json : null)
  max_session_duration = var.max_session_duration
  permissions_boundary = var.permissions_boundary != "" ? var.permissions_boundary : null
  tags                 = local.merged_tags
}

# Inline policies (optional)
resource "aws_iam_role_policy" "inline" {
  for_each = var.inline_policies
  name     = each.key
  role     = aws_iam_role.this.id
  policy   = each.value
}