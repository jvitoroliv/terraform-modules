# GCP URL Map Module

Terraform module for creating GCP URL Map for HTTP(S) load balancing with advanced routing capabilities.

## Features

- Host-based routing
- Path-based routing with regex support
- URL redirects (HTTP to HTTPS, custom redirects)
- Traffic splitting/weighted backends
- Header-based routing
- Query parameter matching
- CORS policy configuration
- Fault injection for testing
- URL rewriting
- Retry policies

## Usage

### Basic URL Map

```hcl
module "url_map" {
  source = "./modules/gcp/lb-url-map"

  name            = "gameplatform-url-map"
  default_service = module.backend_service.self_link

  host_rules = [
    {
      hosts        = ["api.gameplatform.example.com"]
      path_matcher = "api-matcher"
    },
    {
      hosts        = ["*.gameplatform.example.com"]
      path_matcher = "default-matcher"
    }
  ]

  path_matchers = [
    {
      name            = "api-matcher"
      default_service = module.api_backend.self_link
      path_rules = [
        {
          paths   = ["/v1/*"]
          service = module.api_v1_backend.self_link
        },
        {
          paths   = ["/v2/*"]
          service = module.api_v2_backend.self_link
        }
      ]
    },
    {
      name            = "default-matcher"
      default_service = module.default_backend.self_link
    }
  ]
}
```

### HTTP to HTTPS Redirect

```hcl
module "url_map_redirect" {
  source = "./modules/gcp/lb-url-map"

  name = "https-redirect"

  default_url_redirect = {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}
```

### Traffic Splitting (A/B Testing)

```hcl
module "url_map_split" {
  source = "./modules/gcp/lb-url-map"

  name            = "ab-test-url-map"
  default_service = module.backend_v1.self_link

  path_matchers = [
    {
      name            = "split-traffic"
      default_service = module.backend_v1.self_link
      path_rules = [
        {
          paths = ["/api/*"]
          route_action = {
            weighted_backend_services = [
              {
                backend_service = module.backend_v1.self_link
                weight          = 90
              },
              {
                backend_service = module.backend_v2.self_link
                weight          = 10
              }
            ]
          }
        }
      ]
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name of the URL map | `string` | - | yes |
| project | GCP project ID | `string` | `null` | no |
| description | Description of the URL map | `string` | `""` | no |
| default_service | Default backend service | `string` | `null` | no |
| host_rules | List of host rules for routing | `list(object)` | `[]` | no |
| path_matchers | List of path matchers with routing rules | `any` | `[]` | no |
| default_url_redirect | Default URL redirect configuration | `object` | `null` | no |
| tests | List of URL map tests | `list(object)` | `[]` | no |
| header_action | Header action configuration | `any` | `null` | no |
| default_route_action_weighted_backend_services | Weighted backends for default route | `list(object)` | `[]` | no |
| labels | Labels to apply | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of the URL map |
| id | ID of the URL map |
| self_link | Self link of the URL map |
| fingerprint | Fingerprint for conditional updates |
| map_id | Unique identifier for the URL map |

## Path Matcher Features

### Path Rules
- `/exact/path` - Exact path match
- `/prefix/*` - Prefix match with wildcard
- Regex patterns for advanced matching

### Route Actions
- Weighted backend services (traffic splitting)
- URL rewriting (host and path)
- Timeout configuration
- Retry policies
- CORS policies
- Fault injection (delays, aborts)

### Route Rules
- Priority-based routing
- Header matching (exact, regex, prefix, suffix, range)
- Query parameter matching
- Metadata filters

## Redirect Response Codes

- `MOVED_PERMANENTLY_DEFAULT` - 301 redirect
- `FOUND` - 302 redirect
- `SEE_OTHER` - 303 redirect
- `TEMPORARY_REDIRECT` - 307 redirect
- `PERMANENT_REDIRECT` - 308 redirect

## References

- [URL Map Documentation](https://cloud.google.com/load-balancing/docs/url-map)
- [Terraform Resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map)
