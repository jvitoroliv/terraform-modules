# aws/iam-role-policy-attachment

Attaches an IAM policy to a role. Thin wrapper for `aws_iam_role_policy_attachment`.

## Inputs
- `role` (string) – role name
- `policy_arn` (string) – policy ARN

## Outputs
- `role`
- `policy_arn`

## Example
```hcl
module "ecs_task_exec_attach" {
  source     = "../../modules/aws/iam-role-policy-attachment"
  role       = module.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}