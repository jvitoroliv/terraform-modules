# gcp/cloud-nat

Creates a Cloud NAT configuration for outbound internet access from private instances.

## Inputs
- `name` (string) - Cloud NAT name
- `router` (string) - Cloud Router name
- `region` (string) - GCP region
- `nat_ip_allocate_option` (string, default `AUTO_ONLY`) - AUTO_ONLY or MANUAL_ONLY
- `source_subnetwork_ip_ranges_to_nat` (string, default `ALL_SUBNETWORKS_ALL_IP_RANGES`) - NAT source ranges
- `min_ports_per_vm` (number, default `64`) - Minimum ports per VM
- `max_ports_per_vm` (number, optional) - Maximum ports per VM
- `enable_dynamic_port_allocation` (bool, default `false`) - Enable dynamic port allocation
- `enable_endpoint_independent_mapping` (bool, default `true`) - Endpoint independent mapping
- `log_config` (object, optional) - Logging configuration
- `subnetworks` (list[object], default `[]`) - Specific subnetworks to NAT

## Outputs
- `name` - Cloud NAT name
- `id` - Cloud NAT ID

## Example
```hcl
module "nat" {
  source = "./modules/gcp/cloud-nat"

  name   = "gameplatform-nat-us-east1"
  router = module.router.name
  region = "us-east1"

  log_config = {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
```
