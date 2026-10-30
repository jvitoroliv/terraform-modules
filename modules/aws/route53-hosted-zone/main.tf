locals {
  # Determine if this is a private hosted zone
  is_private = length(var.vpc_ids) > 0
  
  # Generate comment if not provided
  zone_comment = var.comment != "" ? var.comment : "Hosted zone for ${var.name}"
}

resource "aws_route53_zone" "this" {
  name              = var.name
  comment           = local.zone_comment
  force_destroy     = var.force_destroy
  delegation_set_id = var.delegation_set_id != "" ? var.delegation_set_id : null

  # VPC association for private hosted zones
  dynamic "vpc" {
    for_each = var.vpc_ids
    content {
      vpc_id     = vpc.value
      vpc_region = var.vpc_region != "" ? var.vpc_region : null
    }
  }

  tags = var.tags
}