# aws/ssm-parameter

Creates an AWS Systems Manager (SSM) Parameter. Defaults to `SecureString` for
storing sensitive values such as DB passwords or API keys.

## Inputs
- `name` (string) – parameter name, use hierarchical paths (`/project/env/key`)
- `type` (string, default `SecureString`)
- `value` (string, optional)
- `overwrite` (bool, default `true`)
- `tier` (string, default `Standard`)
- `kms_key_id` (string, optional)
- `description` (string, optional)
- `allowed_pattern` (string, optional regex)
- `tags` (map)

## Outputs
- `name`
- `arn`
- `version`

## Example
```hcl
module "db_password" {
  source = "../../modules/aws/ssm-parameter"
  name   = "/gameplatform/pr-123/db/password"
  type   = "SecureString"
  value  = "super-secret"
  tags   = { Env = "pr-123" }
}