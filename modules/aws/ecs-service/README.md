# aws/ecs-service

Thin wrapper for `aws_ecs_service` tuned for Fargate + ALB:
networking via `awsvpc`, single target group attachment, optional
capacity provider strategy.

## Inputs
- `name` (string)
- `cluster_arn` (string)
- `task_definition` (string)
- `desired_count` (number, default `1`)
- `launch_type` (string, default `FARGATE`)
- `capacity_provider_strategy` (list[object], optional)
- `platform_version` (string, default `LATEST`)
- `enable_execute_command` (bool, default `true`)
- `network_configuration` (object)
- `load_balancer` (object)
- `deployment_minimum_healthy_percent` (number, default `0`)
- `deployment_maximum_percent` (number, default `200`)
- `propagate_tags` (string, default `SERVICE`)
- `force_new_deployment` (bool, default `false`)
- `wait_for_steady_state` (bool, default `true`)
- `tags` (map)

## Outputs
- `service_arn`
- `service_name`

## Notes
- `desired_count` is ignored in lifecycle to avoid fights with autoscalers.
- Use `capacity_provider_strategy` to prefer **FARGATE_SPOT** without setting `launch_type`.