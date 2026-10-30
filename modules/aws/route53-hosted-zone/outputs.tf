output "zone_id" {
  description = "The hosted zone ID"
  value       = aws_route53_zone.this.zone_id
}

output "arn" {
  description = "The ARN of the hosted zone"
  value       = aws_route53_zone.this.arn
}

output "name" {
  description = "The hosted zone name"
  value       = aws_route53_zone.this.name
}

output "name_servers" {
  description = "List of name servers for the hosted zone"
  value       = aws_route53_zone.this.name_servers
}

output "primary_name_server" {
  description = "The primary name server for the hosted zone"
  value       = aws_route53_zone.this.primary_name_server
}

output "comment" {
  description = "The comment for the hosted zone"
  value       = aws_route53_zone.this.comment
}


output "vpc_ids" {
  description = "List of VPC IDs associated with the hosted zone"
  value       = var.vpc_ids
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider"
  value       = aws_route53_zone.this.tags_all
}
