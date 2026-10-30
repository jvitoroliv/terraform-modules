# gcp/cloud-router

Creates a Google Cloud Router for NAT and VPN configurations.

## Inputs
- `name` (string) - Cloud Router name
- `network` (string) - VPC network self link
- `region` (string) - GCP region
- `project` (string, optional) - GCP project ID
- `description` (string, default `""`) - Description
- `bgp_config` (object, optional) - BGP configuration

## Outputs
- `name` - Cloud Router name
- `id` - Cloud Router ID
- `self_link` - Cloud Router self link

## Example
```hcl
module "router" {
  source = "./modules/gcp/cloud-router"

  name    = "gameplatform-router-us-east1"
  network = module.vpc.self_link
  region  = "us-east1"
}
```
