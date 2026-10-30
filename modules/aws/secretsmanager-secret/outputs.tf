output "arn" {
  description = "Secret ARN."
  value       = aws_secretsmanager_secret.this.arn
}

output "id" {
  description = "Secret ID."
  value       = aws_secretsmanager_secret.this.id
}

output "name" {
  description = "Secret name."
  value       = aws_secretsmanager_secret.this.name
}

output "version_id" {
  description = "Initial version ID (null if no secret_string was provided)."
  value       = try(aws_secretsmanager_secret_version.this[0].version_id, null)
}