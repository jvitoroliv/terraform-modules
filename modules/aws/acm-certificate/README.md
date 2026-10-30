# aws/acm-certificate

Minimal ACM module that issues a **DNS-validated** certificate and creates
the required Route53 records in the provided hosted zone.

## Inputs
- `domain_name` (string) – primary domain (e.g., `*.dev.example.com`)
- `subject_alternative_names` (list[string], optional)
- `validation_dns.hosted_zone_id` (string) – Route53 zone to place validation records
- `tags` (map)

## Outputs
- `certificate_arn`
- `validation_records` (for troubleshooting or auditing)

## Notes
- This issues the certificate in the **current provider region** (works for ALB).
- For **CloudFront**, create the cert in **us-east-1** with an aliased provider.