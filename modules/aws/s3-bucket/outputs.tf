output "id" {
  description = "The S3 bucket name."
  value       = aws_s3_bucket.this.id
}

output "arn" {
  description = "The ARN of the bucket."
  value       = aws_s3_bucket.this.arn
}

output "regional_domain_name" {
  description = "The regional domain name of the bucket."
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}