# aws/dynamodb-table

General-purpose DynamoDB table with sane defaults for ephemeral workloads:
`PAY_PER_REQUEST`, PITR on, SSE on, and optional TTL/streams/GSIs.

## Inputs
- `name` (string)
- `billing_mode` (string, default `PAY_PER_REQUEST`)
- `read_capacity`, `write_capacity` (numbers, only for `PROVISIONED`)
- `hash_key` (string), `range_key` (string, optional)
- `attributes` (list of `{ name, type }`)
- `global_secondary_indexes` (list, optional)
- `ttl` (object `{ attribute_name, enabled }`, optional)
- `stream_enabled` (bool, default `false`)
- `stream_view_type` (string, default `NEW_AND_OLD_IMAGES`)
- `point_in_time_recovery` (bool, default `true`)
- `server_side_encryption` (bool, default `true`)
- `kms_key_arn` (string, optional)
- `tags` (map)

## Outputs
- `table_name`
- `table_arn`
- `stream_arn`
- `stream_label`

## Example
```hcl
module "flags" {
  source = "../../modules/aws/dynamodb-table"

  name        = "gameplatform-pr-123-flags"
  billing_mode= "PAY_PER_REQUEST"
  hash_key    = "PK"
  range_key   = "SK"
  attributes  = [
    { name = "PK", type = "S" },
    { name = "SK", type = "S" },
  ]
  ttl = {
    attribute_name = "expiresAt"
    enabled        = true
  }
  tags = {
    Env = "pr-123"
  }
}