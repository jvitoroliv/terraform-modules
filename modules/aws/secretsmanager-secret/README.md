# aws/secretsmanager-secret

Creates an AWS Secrets Manager secret with secure defaults. Optionally seeds an
initial **secret version** and attaches a **resource policy**.

## Inputs
- `name` (string) – secret name
- `description` (string, optional)
- `kms_key_id` (string, optional) – custom CMK; otherwise AWS-managed key
- `recovery_window_in_days` (number, default `7`) – valid range: 7–30
- `secret_string` (string, optional) – if set, creates an initial version
- `resource_policy_json` (string, optional) – JSON policy via `jsonencode(...)`
- `tags` (map)

## Outputs
- `arn`
- `id`
- `name`
- `version_id` – null if no initial version was created

## Notes
- Avoid hardcoding `secret_string` in VCS; prefer CI variables or
  `terraform apply -var 'secret_string=...'`.