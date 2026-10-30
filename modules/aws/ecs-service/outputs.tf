output "name" {
  description = "Name of the service"
  value       = aws_ecs_service.this.name
}

output "id" {
  description = "ID of the service"
  value       = aws_ecs_service.this.id
}

output "arn" {
  description = "ARN of the service"
  value       = aws_ecs_service.this.id  # ECS service uses ID as ARN
}

output "cluster" {
  description = "Amazon Resource Name (ARN) of cluster which the service runs on"
  value       = aws_ecs_service.this.cluster
}