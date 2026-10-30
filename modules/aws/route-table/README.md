# aws/route-table

Creates a route table and applies one or more routes. Supports the most common
targets (IGW, NAT GW, TGW, VPC Peering, etc.) and IPv4/IPv6 destinations.

## Inputs
- `vpc_id` (string)
- `name` (string)
- `routes` (list[object], optional) – each item may specify **one** target:
  - `cidr_block` or `ipv6_cidr_block`
  - `gateway_id` | `nat_gateway_id` | `transit_gateway_id` | `vpc_peering_connection_id`
  - `egress_only_internet_gateway_id` | `network_interface_id` | `vpc_endpoint_id`
  - `carrier_gateway_id` | `core_network_arn` | `destination_prefix_list_id`
- `propagate_vgw_routes` (bool, default `false`) – disabled by default
- `tags` (map)

## Outputs
- `route_table_id`
- `route_table_arn`

## Example
```hcl
# Public RT
module "rt_public" {
  source = "../../modules/aws/route-table"
  vpc_id = module.vpc.vpc_id
  name   = "gameplatform-pr-123-rt-public"
  routes = [
    { cidr_block = "0.0.0.0/0", gateway_id = module.igw.id }
  ]
}

# Private RT via NAT
module "rt_private" {
  source = "../../modules/aws/route-table"
  vpc_id = module.vpc.vpc_id
  name   = "gameplatform-pr-123-rt-private"
  routes = [
    { cidr_block = "0.0.0.0/0", nat_gateway_id = module.nat.id }
  ]
}