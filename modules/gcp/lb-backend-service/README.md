# GCP Backend Service Module

Terraform module for creating GCP Backend Service with advanced load balancing features.

## Features

- HTTP/HTTPS/HTTP2/TCP/SSL/UDP/GRPC protocol support
- Cloud CDN integration with cache policies
- Identity-Aware Proxy (IAP) support
- Circuit breakers and outlier detection
- Session affinity options
- Custom request/response headers
- Access logging
- Cloud Armor security policy integration
- Health check configuration
- Connection draining
- Consistent hash load balancing

## Usage

```hcl
module "backend_service" {
  source = "./modules/gcp/lb-backend-service"

  name     = "gameplatform-backend"
  protocol = "HTTP"

  health_checks = [module.health_check.self_link]

  backends = [
    {
      group           = google_compute_instance_group.web.self_link
      balancing_mode  = "UTILIZATION"
      max_utilization = 0.8
      capacity_scaler = 1.0
    }
  ]

  enable_cdn = true
  cdn_policy = {
    cache_mode  = "CACHE_ALL_STATIC"
    default_ttl = 3600
    max_ttl     = 86400
  }

  enable_logging   = true
  log_sample_rate  = 0.5

  labels = {
    environment = "production"
    team        = "platform"
  }
}
```

## Example with Cloud Run NEG

```hcl
module "backend_service" {
  source = "./modules/gcp/lb-backend-service"

  name     = "cloud-run-backend"
  protocol = "HTTPS"

  health_checks = [google_compute_health_check.default.self_link]

  backends = [
    {
      group = google_compute_region_network_endpoint_group.cloudrun.id
    }
  ]

  enable_cdn = true
  session_affinity = "GENERATED_COOKIE"
  affinity_cookie_ttl_sec = 3600

  iap = {
    oauth2_client_id     = "client-id.apps.googleusercontent.com"
    oauth2_client_secret = var.iap_client_secret
  }
}
```

## Example with Circuit Breaker

```hcl
module "backend_service" {
  source = "./modules/gcp/lb-backend-service"

  name     = "resilient-backend"
  protocol = "HTTP"

  health_checks = [module.health_check.self_link]
  backends      = [{ group = module.instance_group.self_link }]

  outlier_detection = {
    consecutive_errors              = 5
    consecutive_gateway_failure     = 5
    max_ejection_percent            = 50
    enforcing_consecutive_errors    = 100
    base_ejection_time = {
      seconds = 30
    }
    interval = {
      seconds = 1
    }
  }

  circuit_breakers = {
    max_connections      = 1000
    max_pending_requests = 100
    max_requests         = 1000
    max_retries          = 3
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name of the backend service | `string` | - | yes |
| project | GCP project ID | `string` | `null` | no |
| description | Description of the backend service | `string` | `""` | no |
| protocol | Protocol (HTTP, HTTPS, HTTP2, TCP, SSL, UDP, GRPC) | `string` | `"HTTP"` | no |
| port_name | Backend port name | `string` | `"http"` | no |
| timeout_sec | Backend service timeout in seconds | `number` | `30` | no |
| enable_cdn | Enable Cloud CDN | `bool` | `false` | no |
| session_affinity | Session affinity option | `string` | `"NONE"` | no |
| affinity_cookie_ttl_sec | Cookie TTL for GENERATED_COOKIE affinity | `number` | `0` | no |
| connection_draining_timeout_sec | Connection draining timeout | `number` | `300` | no |
| load_balancing_scheme | Load balancing scheme | `string` | `"EXTERNAL"` | no |
| health_checks | List of health check self_links | `list(string)` | - | yes |
| backends | List of backend configurations | `list(object)` | `[]` | no |
| cdn_policy | CDN policy configuration | `object` | `null` | no |
| iap | Identity-Aware Proxy configuration | `object` | `null` | no |
| enable_logging | Enable access logging | `bool` | `false` | no |
| log_sample_rate | Log sampling rate (0.0-1.0) | `number` | `1.0` | no |
| outlier_detection | Outlier detection for circuit breaking | `object` | `null` | no |
| circuit_breakers | Circuit breaker configuration | `object` | `null` | no |
| consistent_hash | Consistent hash load balancing config | `object` | `null` | no |
| custom_request_headers | Custom request headers | `list(object)` | `null` | no |
| custom_response_headers | Custom response headers | `list(object)` | `null` | no |
| locality_lb_policy | Locality load balancing policy | `string` | `null` | no |
| security_policy | Cloud Armor security policy self_link | `string` | `null` | no |
| security_settings | Security settings for backend | `object` | `null` | no |
| labels | Labels to apply | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of the backend service |
| id | ID of the backend service |
| self_link | Self link of the backend service |
| fingerprint | Fingerprint for conditional updates |
| creation_timestamp | Creation timestamp |
| generated_id | Server-generated unique identifier |

## Session Affinity Options

- `NONE`: No session affinity
- `CLIENT_IP`: Route based on client IP
- `CLIENT_IP_PROTO`: Route based on client IP and protocol
- `CLIENT_IP_PORT_PROTO`: Route based on client IP, port, and protocol
- `GENERATED_COOKIE`: Use generated cookie
- `HEADER_FIELD`: Route based on HTTP header
- `HTTP_COOKIE`: Route based on HTTP cookie

## Load Balancing Schemes

- `EXTERNAL`: External HTTP(S) load balancer
- `INTERNAL`: Internal TCP/UDP load balancer
- `INTERNAL_MANAGED`: Internal HTTP(S) load balancer
- `INTERNAL_SELF_MANAGED`: Traffic Director

## References

- [Backend Service Documentation](https://cloud.google.com/load-balancing/docs/backend-service)
- [Terraform Resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service)
