# aws/alb-target-group

Thin wrapper on `aws_lb_target_group` with sane defaults for HTTP services.

## Inputs
- `name` (string)
- `vpc_id` (string)
- `port` (number)
- `protocol` (string, default `HTTP`)
- `target_type` (string, default `ip`)
- `protocol_version` (string, default `HTTP1`)
- `deregistration_delay` (number, default `10`)
- `health_check` (object, optional) – path/interval/timeout/matcher/etc.
- `stickiness` (object, optional)
- `tags` (map)

## Outputs
- `arn`
- `name`
- `id`

## Example
```hcl
module "tg_app" {
  source   = "../../modules/aws/alb-target-group"
  name     = "gameplatform-pr-123-tg-app"
  vpc_id   = module.vpc.vpc_id
  port     = 3000
  protocol = "HTTP"
  target_type = "ip"
  health_check = {
    path  = "/healthz"
    matcher = "200-399"
  }
}