output "fqdn" {
  description = "FQDN of the created record."
  value       = aws_route53_record.this.fqdn
}

output "name" {
  description = "Record name."
  value       = aws_route53_record.this.name
}