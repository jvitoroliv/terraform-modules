# gcp/cloud-dns-record

Creates a DNS record set in a Cloud DNS managed zone.

## Inputs
- `name` (string) - DNS record name (FQDN with trailing dot)
- `type` (string) - Record type (A, AAAA, CNAME, MX, TXT, etc.)
- `ttl` (number, default `300`) - Time to live in seconds
- `managed_zone` (string) - Managed zone name
- `project` (string, optional) - GCP project ID
- `rrdatas` (list[string]) - List of record values

## Outputs
- `name` - DNS record name
- `id` - DNS record ID
- `type` - DNS record type

## Example
```hcl
module "dns_record_a" {
  source = "./modules/gcp/cloud-dns-record"

  name         = "www.gameplatform.example.com."
  type         = "A"
  ttl          = 300
  managed_zone = module.dns_zone.name

  rrdatas = ["34.98.99.100"]
}

module "dns_record_cname" {
  source = "./modules/gcp/cloud-dns-record"

  name         = "api.gameplatform.example.com."
  type         = "CNAME"
  ttl          = 300
  managed_zone = module.dns_zone.name

  rrdatas = ["www.gameplatform.example.com."]
}
```
