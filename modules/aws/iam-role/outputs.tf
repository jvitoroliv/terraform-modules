output "arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.this.arn
}

output "name" {
  description = "Name of the IAM role"
  value       = aws_iam_role.this.name
}

output "id" {
  description = "IAM role ID."
  value       = aws_iam_role.this.id
}