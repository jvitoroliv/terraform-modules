output "table_name" {
  description = "DynamoDB table name."
  value       = aws_dynamodb_table.this.name
}

output "table_arn" {
  description = "DynamoDB table ARN."
  value       = aws_dynamodb_table.this.arn
}

output "stream_arn" {
  description = "DynamoDB stream ARN (null if disabled)."
  value       = try(aws_dynamodb_table.this.stream_arn, null)
}

output "stream_label" {
  description = "DynamoDB stream label (null if disabled)."
  value       = try(aws_dynamodb_table.this.stream_label, null)
}