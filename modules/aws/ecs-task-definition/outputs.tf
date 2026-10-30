output "arn" {
  description = "Full ARN of the Task Definition"
  value       = aws_ecs_task_definition.this.arn
}

output "family" {
  description = "The family of the Task Definition"
  value       = aws_ecs_task_definition.this.family
}

output "revision" {
  description = "The revision of the task in a particular family"
  value       = aws_ecs_task_definition.this.revision
}