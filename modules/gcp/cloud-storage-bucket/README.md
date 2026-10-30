# gcp/cloud-storage-bucket

Creates a Cloud Storage bucket with versioning, lifecycle rules, and encryption.

## Inputs
- `name` (string) - Bucket name (globally unique)
- `location` (string, default `US`) - Bucket location
- `project` (string, optional) - GCP project ID
- `storage_class` (string, default `STANDARD`) - Storage class
- `force_destroy` (bool, default `false`) - Allow non-empty bucket deletion
- `uniform_bucket_level_access` (bool, default `true`) - Uniform access control
- `versioning_enabled` (bool, default `false`) - Enable versioning
- `lifecycle_rules` (list[object], default `[]`) - Lifecycle rules
- `encryption_key` (string, optional) - KMS encryption key
- `cors_config` (object, optional) - CORS configuration
- `labels` (map, default `{}`) - Resource labels

## Outputs
- `name` - Bucket name
- `id` - Bucket ID
- `self_link` - Bucket self link
- `url` - Bucket URL

## Example
```hcl
module "assets_bucket" {
  source = "./modules/gcp/cloud-storage-bucket"

  name          = "gameplatform-assets-prod"
  location      = "US"
  storage_class = "STANDARD"

  versioning_enabled = true

  lifecycle_rules = [
    {
      action = {
        type          = "SetStorageClass"
        storage_class = "NEARLINE"
      }
      condition = {
        age = 90
      }
    }
  ]

  cors_config = {
    origin = ["https://gameplatform.example.com"]
    method = ["GET", "HEAD", "PUT", "POST"]
    response_header = ["*"]
    max_age_seconds = 3600
  }

  labels = {
    environment = "production"
  }
}
```
