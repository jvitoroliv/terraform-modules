# aws/security-group

Security Group with **inline** ingress/egress blocks. Supports sources via
CIDR, IPv6, prefix lists, other SGs, and `self`.

## Inputs
- `name` (string)
- `description` (string, optional)
- `vpc_id` (string)
- `ingress_rules` (list[object], optional)
- `egress_rules` (list[object], optional; defaults to allow-all)
- `revoke_rules_on_delete` (bool, default `true`)
- `tags` (map)

## Outputs
- `security_group_id`
- `security_group_arn`

## Example
```hcl
module "sg_alb" {
  source      = "../../modules/aws/security-group"
  name        = "gameplatform-pr-123-alb-sg"
  description = "ALB ingress 80/443 from internet"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = [
    { description = "HTTP",  from_port = 80,  to_port = 80,  protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { description = "HTTPS", from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
  ]
}

module "sg_tasks" {
  source      = "../../modules/aws/security-group"
  name        = "gameplatform-pr-123-tasks-sg"
  description = "ECS tasks; allow from ALB"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = [
    { description = "Lobby from ALB",  from_port = 3000, to_port = 3000, protocol = "tcp", security_groups = [module.sg_alb.security_group_id] },
    { description = "Server from ALB", from_port = 8080, to_port = 8080, protocol = "tcp", security_groups = [module.sg_alb.security_group_id] },
  ]
}