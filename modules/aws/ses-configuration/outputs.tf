output "domain_identity" {
  description = "SES domain identity"
  value       = try(aws_ses_domain_identity.main[0].domain, "")
}

output "dkim_tokens" {
  description = "DKIM tokens for DNS verification"
  value       = try(aws_ses_domain_dkim.main[0].dkim_tokens, [])
}

output "smtp_server" {
  description = "SMTP server endpoint"
  value       = "email-smtp.${var.region}.amazonaws.com"
}

output "smtp_port" {
  description = "SMTP port"
  value       = 587
}

output "smtp_username" {
  description = "SMTP username"
  value       = try(aws_iam_access_key.ses_smtp[0].id, "")
  sensitive   = true
}

output "smtp_password" {
  description = "SMTP password"
  value       = local.smtp_password
  sensitive   = true
}

output "from_email" {
  description = "Verified FROM email address"
  value       = var.from_email
}

output "configuration_set_name" {
  description = "SES configuration set name"
  value       = aws_ses_configuration_set.main.name
}