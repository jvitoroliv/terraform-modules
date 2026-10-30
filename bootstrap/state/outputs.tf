output "state_bucket_name" {
  description = "Name of the S3 bucket used for Terraform state."
  value       = aws_s3_bucket.this.bucket
}

output "state_bucket_arn" {
  description = "ARN of the S3 bucket used for Terraform state."
  value       = aws_s3_bucket.this.arn
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table used for Terraform state locking."
  value       = aws_dynamodb_table.locks.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table used for Terraform state locking."
  value       = aws_dynamodb_table.locks.arn
}