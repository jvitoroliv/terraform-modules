output "id" {
  description = "The ID of the service discovery service"
  value       = aws_service_discovery_service.this.id
}

output "arn" {
  description = "The ARN of the service discovery service"
  value       = aws_service_discovery_service.this.arn
}

output "name" {
  description = "The name of the service discovery service"
  value       = aws_service_discovery_service.this.name
}

output "description" {
  description = "The description of the service discovery service"
  value       = aws_service_discovery_service.this.description
}

output "namespace_id" {
  description = "The ID of the namespace used for DNS configuration"
  value       = var.namespace_id
}

output "dns_config" {
  description = "DNS configuration for the service"
  value = {
    namespace_id   = var.namespace_id
    dns_ttl        = var.dns_ttl
    dns_type       = var.dns_type
    routing_policy = var.routing_policy
  }
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider"
  value       = aws_service_discovery_service.this.tags_all
}