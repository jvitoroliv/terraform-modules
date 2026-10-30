# aws/alb

Thin wrapper around `aws_lb` for an **Application Load Balancer** with sane
defaults for PR environments.

## Inputs
- `name` (string) – ALB name
- `subnets` (list[string]) – usually public subnets
- `security_group_ids` (list[string], optional)
- `internal` (bool, default `false`)
- `ip_address_type` (string, default `ipv4`)
- `idle_timeout` (number, default `60`)
- `enable_http2` (bool, default `true`)
- `drop_invalid_header_fields` (bool, default `true`)
- `desync_mitigation_mode` (string, default `defensive`)
- `deletion_protection` (bool, default `false`)
- `access_logs` (object, optional):
  - `enabled` (bool)
  - `bucket` (string)
  - `prefix` (string, optional)
- `tags` (map)

## Outputs
- `arn`
- `id`
- `dns_name`
- `zone_id`

## Example
```hcl
module "alb" {
  source             = "../../modules/aws/alb"
  name               = "gameplatform-pr-123-alb"
  subnets            = module.subnet_public.subnet_ids
  security_group_ids = [module.sg_alb.security_group_id]
  internal           = false
  tags               = { Env = "pr-123" }
}