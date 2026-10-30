# gcp/iam-project-iam-member

Grants an IAM role to a member (user, service account, group) at the project level.

## Inputs
- `project` (string) - GCP project ID
- `role` (string) - IAM role to assign
- `member` (string) - Member to grant role to

## Outputs
- `id` - IAM binding ID
- `etag` - IAM policy ETag

## Example
```hcl
module "grant_storage_viewer" {
  source = "./modules/gcp/iam-project-iam-member"

  project = "gameplatform-dev"
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${module.sa_cloudrun.email}"
}
```
