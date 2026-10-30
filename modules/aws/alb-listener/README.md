# aws/alb-listener

Creates an ALB listener with a flexible **default action** and optional **rules**.

## Inputs
- `load_balancer_arn` (string)
- `port` (number)
- `protocol` (string: `HTTP`|`HTTPS`)
- `certificate_arn` (string, required for HTTPS)
- `ssl_policy` (string, default `ELBSecurityPolicy-2016-08`)
- `default_action` (object) – `forward`, `redirect`, or `fixed-response`
- `rules` (list[object], optional) – host/path/header conditions + forward action
- `tags` (map) – applied to rules

## Outputs
- `listener_arn`
- `listener_id`
- `rule_arns`

## Examples

**HTTP listener that redirects to HTTPS**
```hcl
module "listener_http" {
  source            = "../../modules/aws/alb-listener"
  load_balancer_arn = module.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action = {
    type = "redirect"
    redirect = { port = "443", protocol = "HTTPS", status_code = "HTTP_301" }
  }
}