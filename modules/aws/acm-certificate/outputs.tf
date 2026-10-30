output "certificate_arn" {
  description = "ARN of the validated ACM certificate."
  value       = aws_acm_certificate_validation.this.certificate_arn
}

output "validation_records" {
  description = "Map of validation DNS records that were created."
  value = {
    for k, r in aws_route53_record.validation :
    k => {
      fqdn  = r.fqdn
      name  = r.name
      type  = r.type
      values = r.records
    }
  }
}
