# gcp/firewall-rule

Creates a Google Compute firewall rule with allow/deny rules.

## Inputs
- `name` (string) - Firewall rule name
- `network` (string) - VPC network self link
- `project` (string, optional) - GCP project ID
- `description` (string, default `""`) - Description
- `direction` (string, default `INGRESS`) - INGRESS or EGRESS
- `priority` (number, default `1000`) - Rule priority (0-65535)
- `source_ranges` (list[string], default `[]`) - Source CIDR ranges
- `destination_ranges` (list[string], default `[]`) - Destination CIDR ranges
- `source_tags` (list[string], default `[]`) - Source tags
- `target_tags` (list[string], default `[]`) - Target tags
- `source_service_accounts` (list[string], default `[]`) - Source service accounts
- `target_service_accounts` (list[string], default `[]`) - Target service accounts
- `allow_rules` (list[object], default `[]`) - Allow rules
- `deny_rules` (list[object], default `[]`) - Deny rules
- `disabled` (bool, default `false`) - Disable rule

## Outputs
- `name` - Firewall rule name
- `id` - Firewall rule ID
- `self_link` - Firewall rule self link

## Example
```hcl
module "firewall_allow_http" {
  source = "./modules/gcp/firewall-rule"

  name    = "allow-http-https"
  network = module.vpc.self_link

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]

  allow_rules = [
    {
      protocol = "tcp"
      ports    = ["80", "443"]
    }
  ]
}
```
