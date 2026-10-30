locals {
  merged_tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy

  tags = local.merged_tags
}