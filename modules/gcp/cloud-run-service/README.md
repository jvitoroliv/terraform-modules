# gcp/cloud-run-service

Creates a Cloud Run Gen2 service with container configuration and autoscaling.

## Inputs
- `name` (string) - Service name
- `location` (string) - GCP region
- `project` (string, optional) - GCP project ID
- `description` (string, default `""`) - Description
- `container` (object) - Container configuration (image, port, env_vars, resources)
- `min_instance_count` (number, default `0`) - Min instances (0 = scale to zero)
- `max_instance_count` (number, default `10`) - Max instances
- `max_instance_request_concurrency` (number, default `80`) - Concurrent requests per instance
- `timeout` (string, default `"300s"`) - Request timeout
- `service_account` (string, optional) - Service account email
- `vpc_access` (object, optional) - VPC Access Connector
- `allow_unauthenticated` (bool, default `false`) - Allow public access
- `labels` (map, default `{}`) - Resource labels

## Outputs
- `name` - Service name
- `id` - Service ID
- `uri` - Service URI (URL)
- `latest_ready_revision` - Latest ready revision

## Example
```hcl
module "cloud_run_lobby" {
  source = "./modules/gcp/cloud-run-service"

  name     = "gameplatform-lobby"
  location = "us-east1"

  container = {
    name  = "lobby"
    image = "us-east1-docker.pkg.dev/gameplatform-dev/gameplatform/lobby:latest"
    port  = 3000
    env_vars = [
      { name = "NODE_ENV", value = "production" },
      { name = "DB_PASSWORD", secret = { secret = "db-password", version = "latest" } }
    ]
    resources = {
      cpu    = "1000m"
      memory = "512Mi"
    }
  }

  min_instance_count = 1
  max_instance_count = 10

  allow_unauthenticated = true

  labels = {
    environment = "production"
  }
}
```
