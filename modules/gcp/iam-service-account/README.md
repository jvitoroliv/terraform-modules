# gcp/iam-service-account

Creates a Google Cloud IAM service account.

## Inputs
- `account_id` (string) - Service account ID (unique identifier)
- `display_name` (string, default `""`) - Display name
- `description` (string, default `""`) - Description
- `project` (string, optional) - GCP project ID

## Outputs
- `email` - Service account email
- `name` - Service account name
- `unique_id` - Unique ID
- `id` - Full resource ID

## Example
```hcl
module "sa_cloudrun" {
  source = "./modules/gcp/iam-service-account"

  account_id   = "cloudrun-lobby"
  display_name = "Cloud Run Lobby Service Account"
  description  = "Service account for Cloud Run lobby service"
}
```
