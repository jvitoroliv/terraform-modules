output "id" {
  description = "The Auto Scaling Group ID"
  value       = aws_autoscaling_group.this.id
}

output "name" {
  description = "The Auto Scaling Group name"
  value       = aws_autoscaling_group.this.name
}

output "arn" {
  description = "The ARN for this Auto Scaling Group"
  value       = aws_autoscaling_group.this.arn
}

output "availability_zones" {
  description = "The availability zones of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.availability_zones
}

output "min_size" {
  description = "The minimum size of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.min_size
}

output "max_size" {
  description = "The maximum size of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.max_size
}

output "desired_capacity" {
  description = "The number of instances that should be running in the group"
  value       = aws_autoscaling_group.this.desired_capacity
}

output "default_cooldown" {
  description = "The default cooldown for this Auto Scaling Group"
  value       = aws_autoscaling_group.this.default_cooldown
}

output "health_check_type" {
  description = "The health check type for the Auto Scaling Group"
  value       = aws_autoscaling_group.this.health_check_type
}

output "health_check_grace_period" {
  description = "The health check grace period for the Auto Scaling Group"
  value       = aws_autoscaling_group.this.health_check_grace_period
}