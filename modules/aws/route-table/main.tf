locals {
  merged_tags = merge({ Name = var.name }, var.tags)

  # build a friendly index for routes
  indexed_routes = {
    for idx, r in var.routes : idx => r
  }
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  tags   = local.merged_tags
}

# Optional VGW propagation
resource "aws_vpn_gateway_route_propagation" "this" {
  count          = var.propagate_vgw_routes ? 1 : 0
  route_table_id = aws_route_table.this.id
  # NOTE: this resource requires a vpn_gateway_id, which varies per project.
  # If you need it, wrap another module that discovers your VGW id or pass it
  # as a separate variable and wire it here.
  # For this generic module, we leave it disabled by default.
  vpn_gateway_id = var.vpn_gateway_id
  lifecycle {
    precondition {
      condition     = (!var.propagate_vgw_routes) || (var.vpn_gateway_id != null && length(trimspace(var.vpn_gateway_id)) > 0)
      error_message = "When propagate_vgw_routes is true, a valid vpn_gateway_id must be set."
    }
  }
}

# Create routes. Each route can target only one next-hop type.
resource "aws_route" "this" {
  for_each               = local.indexed_routes
  route_table_id         = aws_route_table.this.id

  destination_cidr_block      = try(each.value.cidr_block, null)
  destination_ipv6_cidr_block = try(each.value.ipv6_cidr_block, null)
  destination_prefix_list_id  = try(each.value.destination_prefix_list_id, null)

  gateway_id                      = try(each.value.gateway_id, null)
  nat_gateway_id                  = try(each.value.nat_gateway_id, null)
  transit_gateway_id              = try(each.value.transit_gateway_id, null)
  vpc_peering_connection_id       = try(each.value.vpc_peering_connection_id, null)
  egress_only_gateway_id = try(each.value.egress_only_internet_gateway_id, null)
  network_interface_id            = try(each.value.network_interface_id, null)
  vpc_endpoint_id                 = try(each.value.vpc_endpoint_id, null)
  carrier_gateway_id              = try(each.value.carrier_gateway_id, null)
  core_network_arn                = try(each.value.core_network_arn, null)
}
