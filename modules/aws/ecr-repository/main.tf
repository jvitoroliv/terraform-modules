locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.force_delete

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.encryption_type == "KMS" && var.kms_key != "" ? var.kms_key : null
  }

  tags = local.merged_tags
}

# Lifecycle policy:
# - If custom JSON is provided, use it.
# - Else, optionally keep only last N images (if lifecycle_keep_last > 0).
locals {
  lifecycle_policy_json_effective = var.lifecycle_policy_json != "" ? var.lifecycle_policy_json : (
    var.lifecycle_keep_last > 0 ? jsonencode({
      rules = [{
        rulePriority = 1
        description  = "Keep last ${var.lifecycle_keep_last} images"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = var.lifecycle_keep_last
        }
        action = { type = "expire" }
      }]
    }) : ""
  )
}

resource "aws_ecr_lifecycle_policy" "this" {
  count      = local.lifecycle_policy_json_effective != "" ? 1 : 0
  repository = aws_ecr_repository.this.name
  policy     = local.lifecycle_policy_json_effective
}