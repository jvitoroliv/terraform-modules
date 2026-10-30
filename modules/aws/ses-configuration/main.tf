# AWS SES Configuration Module
# This module sets up SES for sending emails

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

# SES Domain Identity
resource "aws_ses_domain_identity" "main" {
  count  = var.domain_name != "" ? 1 : 0
  domain = var.domain_name
}

# SES Domain DKIM
resource "aws_ses_domain_dkim" "main" {
  count  = var.domain_name != "" ? 1 : 0
  domain = aws_ses_domain_identity.main[0].domain
}

# SES Email Identity (for FROM address)
resource "aws_ses_email_identity" "main" {
  count = var.from_email != "" ? 1 : 0
  email = var.from_email
}

# SES Configuration Set
resource "aws_ses_configuration_set" "main" {
  name = var.configuration_set_name

  reputation_metrics_enabled = var.reputation_metrics_enabled
  
  delivery_options {
    tls_policy = "Require"
  }
}

# SES Event Destination for tracking
resource "aws_ses_event_destination" "cloudwatch" {
  count                  = var.enable_cloudwatch_tracking ? 1 : 0
  name                   = "${var.configuration_set_name}-cloudwatch"
  configuration_set_name = aws_ses_configuration_set.main.name
  enabled                = true

  cloudwatch_destination {
    default_value  = "default"
    dimension_name = "MessageTag"
    value_source   = "messageTag"
  }

  matching_types = ["bounce", "complaint", "delivery", "reject", "send"]
}

# IAM User for SMTP credentials
resource "aws_iam_user" "ses_smtp" {
  count = var.create_smtp_user ? 1 : 0
  name  = var.smtp_user_name
  path  = "/system/"

  tags = var.tags
}

# IAM Policy for SES sending
resource "aws_iam_user_policy" "ses_sender" {
  count = var.create_smtp_user ? 1 : 0
  name  = "${var.smtp_user_name}-ses-sender"
  user  = aws_iam_user.ses_smtp[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail",
          "ses:SendTemplatedEmail"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "ses:FromAddress" = var.from_email != "" ? var.from_email : "*"
          }
        }
      }
    ]
  })
}

# SMTP credentials
resource "aws_iam_access_key" "ses_smtp" {
  count = var.create_smtp_user ? 1 : 0
  user  = aws_iam_user.ses_smtp[0].name
}

# Since we're using hardcoded SMTP credentials for dev, skip password generation
locals {
  smtp_password = var.create_smtp_user ? "hardcoded-smtp-password-placeholder" : ""
}