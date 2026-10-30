# aws/route-table-association

Creates one or more associations between subnets or gateways (IGW/VGW) and a
route table.

## Inputs
- `associations` (list[object]):
  - `route_table_id` (string)
  - `subnet_id` (string, optional) – **mutually exclusive** with `gateway_id`
  - `gateway_id` (string, optional) – for IGW/VGW associations

## Outputs
- `association_ids` (list)

## Example
```hcl
# Associate two public subnets to a public route table
module "rt_assoc_public" {
  source = "../../modules/aws/route-table-association"
  associations = [
    { subnet_id = module.subnet_public.subnet_ids[0], route_table_id = module.rt_public.route_table_id },
    { subnet_id = module.subnet_public.subnet_ids[1], route_table_id = module.rt_public.route_table_id },
  ]
}

# Associate the Internet Gateway to the same public route table (optional)
module "rt_assoc_igw" {
  source = "../../modules/aws/route-table-association"
  associations = [
    { gateway_id = module.igw.id, route_table_id = module.rt_public.route_table_id }
  ]
}