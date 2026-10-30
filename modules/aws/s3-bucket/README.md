# aws/s3-bucket

Minimal S3 bucket for ephemeral or persistent storage. Secure defaults:
- force destroy enabled
- block public access
- server-side encryption (AES256)

## Inputs
- `name` (string)
- `force_destroy` (bool, default `true`)
- `block_public_access` (bool, default `true`)
- `versioning` (bool, default `false`)
- `server_side_encryption` (bool, default `true`)
- `tags` (map)

## Outputs
- `id`
- `arn`
- `regional_domain_name`

## Example
```hcl
module "bucket_assets" {
  source     = "../../modules/aws/s3-bucket"
  name       = "gameplatform-pr-123-assets"
  versioning = false
  tags       = { Env = "pr-123" }
}