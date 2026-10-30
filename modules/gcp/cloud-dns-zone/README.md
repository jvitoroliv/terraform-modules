# gcp/cloud-dns-zone

Creates a Google Cloud DNS managed zone (public or private).

## Inputs
- `name` (string) - DNS zone name (unique identifier)
- `dns_name` (string) - DNS domain name (must end with dot)
- `description` (string, default `""`) - Description
- `project` (string, optional) - GCP project ID
- `visibility` (string, default `public`) - public or private
- `private_visibility_config` (object, optional) - Private zone VPC networks
- `dnssec_config` (object, optional) - DNSSEC configuration
- `labels` (map, default `{}`) - Resource labels

## Outputs
- `name` - DNS zone name
- `id` - DNS zone ID
- `dns_name` - DNS domain name
- `name_servers` - List of authoritative name servers

## Example
```hcl
module "dns_zone" {
  source = "./modules/gcp/cloud-dns-zone"

  name     = "gameplatform-zone"
  dns_name = "gameplatform.example.com."

  dnssec_config = {
    state = "on"
  }

  labels = {
    environment = "production"
  }
}
```
