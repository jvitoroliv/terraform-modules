output "id" {
  description = "ID of the Internet Gateway."
  value       = aws_internet_gateway.this.id
}

output "arn" {
  description = "ARN of the Internet Gateway."
  value       = aws_internet_gateway.this.arn
}