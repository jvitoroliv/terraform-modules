output "arn" {
  description = "ARN of the listener rule"
  value       = aws_lb_listener_rule.this.arn
}

output "id" {
  description = "ID of the listener rule"
  value       = aws_lb_listener_rule.this.id
}

output "priority" {
  description = "Priority of the listener rule"
  value       = aws_lb_listener_rule.this.priority
}

output "listener_arn" {
  description = "ARN of the associated listener"
  value       = aws_lb_listener_rule.this.listener_arn
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider"
  value       = aws_lb_listener_rule.this.tags_all
}