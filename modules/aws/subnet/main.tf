# If availability_zone is not provided, we pick AZs in order using the
# region's available AZs, cycling if needed.
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = data.aws_availability_zones.available.names

  indexed_subnets = {
    for idx, s in var.subnets :
    idx => merge(
      s,
      {
        # auto-pick AZ if not provided (round-robin)
        availability_zone = try(s.availability_zone, null) != null ? s.availability_zone : local.azs[idx % length(local.azs)]
        map_public_ip_on_launch = try(s.map_public_ip_on_launch, false)
      }
    )
  }
}

resource "aws_subnet" "this" {
  for_each = local.indexed_subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  # Public subnets in PR POC should set this to true
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(
    {
      Name = each.value.name
    },
    var.tags
  )
}