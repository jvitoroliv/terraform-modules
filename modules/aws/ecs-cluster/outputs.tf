output "arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.this.arn
}

output "name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.this.name
}

output "id" {
  description = "ECS cluster ID."
  value       = aws_ecs_cluster.this.id
}