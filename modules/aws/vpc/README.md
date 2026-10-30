# aws/vpc

Minimal VPC module. Exposes only what the PR environments need:
- DNS support/hostnames enabled by default
- Clean interface: `name`, `cidr_block`, and `tags`

## Inputs
- `name` (string): Name tag for the VPC  
- `cidr_block` (string): IPv4 CIDR  
- `enable_dns_support` (bool, default `true`)  
- `enable_dns_hostnames` (bool, default `true`)  
- `instance_tenancy` (string, default `default`)  
- `tags` (map)

## Outputs
- `vpc_id`
- `vpc_arn`
- `cidr_block`

## Example
```hcl
module "vpc" {
  source     = "../../modules/aws/vpc"
  name       = "gameplatform-pr-123-vpc"
  cidr_block = "10.80.0.0/16"
  tags       = { Env = "pr-123" }
}