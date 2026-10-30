variable "domain_name" {
  description = "Domain name for SES verification"
  type        = string
  default     = ""
}

variable "from_email" {
  description = "Email address to send emails from"
  type        = string
  default     = ""
}

variable "configuration_set_name" {
  description = "Name of the SES configuration set"
  type        = string
}

variable "reputation_metrics_enabled" {
  description = "Enable reputation tracking"
  type        = bool
  default     = true
}

variable "enable_cloudwatch_tracking" {
  description = "Enable CloudWatch event tracking"
  type        = bool
  default     = true
}

variable "create_smtp_user" {
  description = "Create IAM user for SMTP authentication"
  type        = bool
  default     = true
}

variable "smtp_user_name" {
  description = "Name of the IAM user for SMTP"
  type        = string
  default     = "ses-smtp-user"
}

variable "region" {
  description = "AWS region for SES"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}