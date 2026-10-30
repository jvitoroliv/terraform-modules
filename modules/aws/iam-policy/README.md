# aws/iam-policy

Wrapper for creating custom IAM policies.

## Inputs
- `name` (string)
- `description` (string, optional)
- `path` (string, default `/`)
- `policy` (string; must be JSON, usually via `jsonencode`)
- `tags` (map)

## Outputs
- `arn`
- `id`
- `name`

## Example
```hcl
module "ssm_read_policy" {
  source = "../../modules/aws/iam-policy"

  name        = "gameplatform-pr-123-ssm-read"
  description = "Allow ECS tasks to read SSM params"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["ssm:GetParameter", "ssm:GetParameters"],
      Resource = "*"
    }]
  })
}