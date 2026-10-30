locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
  tags   = local.merged_tags
}