output "arn" {
  description = "ARN of the ALB."
  value       = aws_lb.this.arn
}

output "id" {
  description = "ID of the ALB."
  value       = aws_lb.this.id
}

output "dns_name" {
  description = "DNS name of the ALB."
  value       = aws_lb.this.dns_name
}

output "zone_id" {
  description = "Route53 hosted zone ID of the ALB. Useful for ALIAS records."
  value       = aws_lb.this.zone_id
}