# aws/subnet

Creates one or more subnets in a given Vpc. If an `availability_zone` is not
provided for an item, the module picks AZs in order (round-robin) based on
the region's available AZs.

## Inputs
- `vpc_id` (string): Target VPC
- `subnets` (list of objects):
  - `cidr_block` (string) – required
  - `availability_zone` (string, optional)
  - `name` (string) – required
  - `map_public_ip_on_launch` (bool, default `false`)
- `tags` (map): Extra tags

## Outputs
- `subnet_ids` (list)
- `subnet_arns` (list)
- `subnet_map` (map `name` => `id`)

## Example
```hcl
module "subnet_public" {
  source = "../../modules/aws/subnet"

  vpc_id = module.vpc.vpc_id
  subnets = [
    {
      name                    = "gameplatform-pr-123-public-a"
      cidr_block              = "10.80.10.0/24"
      map_public_ip_on_launch = true
    },
    {
      name                    = "gameplatform-pr-123-public-b"
      cidr_block              = "10.80.11.0/24"
      map_public_ip_on_launch = true
    }
  ]
  tags = { Tier = "public" }
}