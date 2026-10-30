# aws/internet-gateway

Creates a simple Internet Gateway and attaches it to a VPC.

## Inputs
- `name` (string) – Name tag
- `vpc_id` (string) – VPC ID
- `tags` (map)

## Outputs
- `id` – Internet Gateway ID
- `arn` – Internet Gateway ARN

## Example
```hcl
module "igw" {
  source = "../../modules/aws/internet-gateway"
  name   = "gameplatform-pr-123-igw"
  vpc_id = module.vpc.vpc_id
  tags   = { Env = "pr-123" }
}