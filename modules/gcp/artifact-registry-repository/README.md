# gcp/artifact-registry-repository

Creates an Artifact Registry repository for Docker images, npm packages, etc.

## Inputs
- `repository_id` (string) - Repository ID
- `location` (string) - GCP region
- `format` (string, default `DOCKER`) - Repository format
- `project` (string, optional) - GCP project ID
- `description` (string, default `""`) - Description
- `docker_immutable_tags` (bool, default `false`) - Immutable tags for Docker
- `labels` (map, default `{}`) - Resource labels

## Outputs
- `name` - Repository name
- `id` - Repository ID

## Example
```hcl
module "docker_registry" {
  source = "./modules/gcp/artifact-registry-repository"

  repository_id = "gameplatform"
  location      = "us-east1"
  format        = "DOCKER"
  description   = "GamePlatform Docker images"

  docker_immutable_tags = true

  labels = {
    environment = "production"
  }
}
```
