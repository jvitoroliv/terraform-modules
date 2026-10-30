# aws/route53-record

Creates a Route53 DNS record. Supports simple records and ALIAS targets (e.g., ALB).

## Inputs
- `zone_id` (string)
- `name` (string)
- `type` (string)
- `ttl` (number, default `300`)
- `records` (list[string], default `[]`)
- `alias` (object, optional)
- `allow_overwrite` (bool, default `true`)

## Outputs
- `fqdn`
- `name`

## Example
```hcl
# Simple A record
module "dns_app" {
  source  = "../../modules/aws/route53-record"
  zone_id = var.zone_id
  name    = "app-pr123.dev.example.com"
  type    = "A"
  alias   = {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}