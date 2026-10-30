output "id" {
  description = "The ID of the service discovery namespace"
  value       = aws_service_discovery_private_dns_namespace.this.id
}

output "arn" {
  description = "The ARN of the service discovery namespace"
  value       = aws_service_discovery_private_dns_namespace.this.arn
}

output "name" {
  description = "The name of the service discovery namespace"
  value       = aws_service_discovery_private_dns_namespace.this.name
}

output "hosted_zone" {
  description = "The ID of the hosted zone that Amazon Route 53 creates when you create a namespace"
  value       = aws_service_discovery_private_dns_namespace.this.hosted_zone
}

output "description" {
  description = "The description of the service discovery namespace"
  value       = aws_service_discovery_private_dns_namespace.this.description
}

output "vpc_id" {
  description = "The VPC ID associated with the namespace"
  value       = var.vpc_id
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider"
  value       = aws_service_discovery_private_dns_namespace.this.tags_all
}