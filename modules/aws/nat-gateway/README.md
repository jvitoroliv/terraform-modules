# aws/nat-gateway

Creates a NAT Gateway using a provided Elastic IP and subnet.

## Inputs
- `name` (string) – Name tag
- `subnet_id` (string) – must be a public subnet
- `allocation_id` (string) – Elastic IP allocation ID
- `tags` (map)

## Outputs
- `id` – NAT Gateway ID
- `public_ip` – NAT Gateway public IP

## Example
```hcl
module "nat" {
  source       = "../../modules/aws/nat-gateway"
  name         = "gameplatform-pr-123-nat"
  subnet_id    = module.subnet_public.subnet_ids[0]
  allocation_id = module.eip_nat.id
  tags         = { Env = "pr-123" }
}