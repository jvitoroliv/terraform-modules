# aws/iam-role

Wrapper for creating IAM roles with custom assume-role policies.

## Inputs
- `name` (string)
- `assume_role_policy` (string, JSON; usually built with `jsonencode(data.aws_iam_policy_document...)`)
- `path` (string, default `/`)
- `description` (string, optional)
- `max_session_duration` (number, default `3600`)
- `permissions_boundary` (string, optional)
- `tags` (map)

## Outputs
- `arn`
- `id`
- `name`

## Example
```hcl
data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

module "ecs_task_execution_role" {
  source             = "../../modules/aws/iam-role"
  name               = "gameplatform-pr-123-ecs-exec"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
  tags               = { Env = "pr-123" }
}