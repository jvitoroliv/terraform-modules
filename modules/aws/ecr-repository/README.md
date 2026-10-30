# aws/ecr-repository

Minimal ECR repository with optional lifecycle policy to cap image count (keep last N).
Defaults are safe for PR environments (immutable tags, scan on push, force delete).

## Inputs
- `name` (string) – repository name
- `image_tag_mutability` (string, default `IMMUTABLE`)
- `scan_on_push` (bool, default `true`)
- `encryption_type` (string: `AES256`|`KMS`, default `AES256`)
- `kms_key` (string, required if `encryption_type = KMS`)
- `force_delete` (bool, default `true`)
- `lifecycle_keep_last` (number, default `10`)
- `lifecycle_policy_json` (string, optional; overrides `lifecycle_keep_last`)
- `tags` (map)

## Outputs
- `repository_arn`
- `repository_name`
- `repository_url`

## Example
```hcl
module "ecr_server" {
  source = "../../modules/aws/ecr-repository"
  name   = "gameplatform/server"
  tags   = { Env = "pr-123" }
}

module "ecr_lobby" {
  source = "../../modules/aws/ecr-repository"
  name   = "gameplatform/lobby"
  tags   = { Env = "pr-123" }
}