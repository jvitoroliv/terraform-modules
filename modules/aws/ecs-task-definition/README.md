# aws/ecs-task-definition

Single-container ECS task definition tuned for Fargate PR environments:
awslogs, optional SSM secrets, minimal knobs.

## Inputs
- `family` (string)
- `network_mode` (string, default `awsvpc`)
- `requires_compatibilities` (list[string], default `["FARGATE"]`)
- `cpu` (number), `memory` (number)
- `execution_role_arn` (string)
- `task_role_arn` (string)
- `ephemeral_storage_size` (number, default `20`)
- `container` (object):
  - `name`, `image` (string)
  - `port_mappings` (list of `{ container_port, host_port, protocol }`)
  - `log_group_name` (string)
  - `environment` (map, optional)
  - `ssm_secret_paths` (list[string], optional)
  - `essential` (bool, optional)
- `tags` (map)

## Outputs
- `arn`
- `family`
- `revision`

## Notes
- The log driver is **awslogs**; region is resolved via `data.aws_region.current`.
- Pass SSM parameter names or ARNs in `ssm_secret_paths`; your **execution role** needs `ssm:GetParameter(s)`.