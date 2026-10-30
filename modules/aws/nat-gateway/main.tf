locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

resource "aws_nat_gateway" "this" {
  subnet_id     = var.subnet_id
  allocation_id = var.allocation_id

  tags = local.merged_tags
}