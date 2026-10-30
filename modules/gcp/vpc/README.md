# gcp/vpc

Creates a Google Compute VPC network with configurable routing mode and MTU.

## Inputs
- `name` (string) - VPC network name
- `project` (string, optional) - GCP project ID
- `auto_create_subnetworks` (bool, default `false`) - Auto-create regional subnets
- `routing_mode` (string, default `REGIONAL`) - REGIONAL or GLOBAL
- `mtu` (number, default `1460`) - Maximum Transmission Unit (1460-1500)
- `description` (string, default `""`) - Description
- `delete_default_routes_on_create` (bool, default `false`) - Remove default routes
- `labels` (map, default `{}`) - Resource labels

## Outputs
- `name` - VPC network name
- `id` - VPC network ID
- `self_link` - VPC network self link
- `gateway_ipv4` - Gateway IPv4 address

## Example
```hcl
module "vpc" {
  source = "./modules/gcp/vpc"

  name         = "gameplatform-vpc"
  project      = "gameplatform-dev"
  routing_mode = "GLOBAL"
  mtu          = 1500

  labels = {
    environment = "dev"
  }
}
```
