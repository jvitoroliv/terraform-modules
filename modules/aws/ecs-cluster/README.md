# aws/ecs-cluster

Creates a bare ECS cluster with optional **Container Insights** and links the
`FARGATE` / `FARGATE_SPOT` capacity providers. You can also set a default
capacity provider strategy to bias new services.

## Inputs
- `name` (string)
- `enable_container_insights` (bool, default `true`)
- `default_capacity_providers` (list[string], default `["FARGATE"]`)
- `default_capacity_provider_strategy` (list[object], optional)
- `tags` (map)

## Outputs
- `name`
- `arn`
- `id`

## Examples

**FARGATE only**
```hcl
module "ecs_cluster" {
  source = "../../modules/aws/ecs-cluster"
  name   = "gameplatform-pr-123-ecs"
  tags   = { Env = "pr-123" }
}