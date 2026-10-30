output "id" {
  description = "ID of the security group"
  value       = aws_security_group.this.id
}

output "security_group_id" {
  description = "ID of the security group (alias)"
  value       = aws_security_group.this.id
}

output "name" {
  description = "Name of the security group"
  value       = aws_security_group.this.name
}

output "security_group_arn" {
  description = "Security Group ARN."
  value       = aws_security_group.this.arn
}