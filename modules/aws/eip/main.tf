locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

resource "aws_eip" "this" {
  domain = "vpc"
  tags   = local.merged_tags
}