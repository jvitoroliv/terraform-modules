output "listener_arn" {
  description = "ARN of the created ALB listener."
  value       = aws_lb_listener.this.arn
}

output "listener_id" {
  description = "ID of the created ALB listener."
  value       = aws_lb_listener.this.id
}

output "rule_arns" {
  description = "ARNs of the created listener rules."
  value       = [for r in aws_lb_listener_rule.this : r.arn]
}