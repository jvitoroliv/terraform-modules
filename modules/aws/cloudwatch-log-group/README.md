# aws/cloudwatch-log-group

Thin wrapper for a CloudWatch Log Group with retention, optional KMS, and
`INFREQUENT_ACCESS` support.

## Inputs
- `name` (string) – log group name
- `retention_in_days` (number, default `7`)
- `kms_key_id` (string, optional)
- `log_group_class` (string, `STANDARD`|`INFREQUENT_ACCESS`, default `STANDARD`)
- `skip_destroy` (bool, default `false`)
- `tags` (map)

## Outputs
- `name`
- `arn`

## Notes
- For ephemeral envs, short retention keeps costs low.
- `INFREQUENT_ACCESS` can cut costs if logs are rarely queried.