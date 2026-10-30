# gcp/subnet

Creates a Google Compute subnetwork with optional secondary IP ranges for GKE.

## Inputs
- `name` (string) - Subnet name
- `ip_cidr_range` (string) - Primary IP CIDR range
- `region` (string) - GCP region
- `network` (string) - VPC network self link
- `project` (string, optional) - GCP project ID
- `description` (string, default `""`) - Description
- `private_ip_google_access` (bool, default `true`) - Enable private Google API access
- `log_config` (object, optional) - VPC flow logs configuration
- `secondary_ip_ranges` (list[object], default `[]`) - Secondary IP ranges for GKE

## Outputs
- `name` - Subnet name
- `id` - Subnet ID
- `self_link` - Subnet self link
- `gateway_address` - Gateway address
- `ip_cidr_range` - IP CIDR range

## Example
```hcl
module "subnet" {
  source = "./modules/gcp/subnet"

  name          = "gameplatform-subnet-us-east1"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-east1"
  network       = module.vpc.self_link

  secondary_ip_ranges = [
    {
      range_name    = "pods"
      ip_cidr_range = "10.1.0.0/16"
    },
    {
      range_name    = "services"
      ip_cidr_range = "10.2.0.0/16"
    }
  ]
}
```
