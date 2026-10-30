# aws/eip

Thin wrapper for an Elastic IP allocation. Ephemeral envs often use this
together with a NAT Gateway.

## Inputs
- `name` (string) – Name tag
- `vpc` (bool, default `true`) – whether to allocate in VPC scope
- `tags` (map)

## Outputs
- `id` – allocation ID
- `public_ip` – IPv4 address

## Example
```hcl
module "eip_nat" {
  source = "../../modules/aws/eip"
  name   = "gameplatform-pr-123-nat-eip"
  tags   = { Env = "pr-123" }
}