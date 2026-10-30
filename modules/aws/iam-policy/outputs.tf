output "arn" {
  description = "The ARN of the IAM policy."
  value       = aws_iam_policy.this.arn
}

output "id" {
  description = "The IAM policy ID."
  value       = aws_iam_policy.this.id
}

output "name" {
  description = "The IAM policy name."
  value       = aws_iam_policy.this.name
}