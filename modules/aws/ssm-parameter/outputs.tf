output "name" {
  description = "SSM parameter name."
  value       = aws_ssm_parameter.this.name
}

output "arn" {
  description = "SSM parameter ARN."
  value       = aws_ssm_parameter.this.arn
}

output "version" {
  description = "Current parameter version."
  value       = aws_ssm_parameter.this.version
}