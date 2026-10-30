variable "name" {
  description = "Secret name."
  type        = string
}

variable "description" {
  description = "Human-readable description for the secret."
  type        = string
  default     = ""
}

variable "kms_key_id" {
  description = "KMS key ARN/ID used to encrypt the secret. If empty, AWS-managed key is used."
  type        = string
  default     = ""
}

variable "recovery_window_in_days" {
  description = "Recovery window when scheduling deletion (7–30 days)."
  type        = number
  default     = 7
}

variable "secret_string" {
  description = <<-EOT
    Initial secret value (plain string). If empty, no secret version is created.
    For CI, prefer passing values via TF_VAR_secret_string or a separate pipeline step.
  EOT
  type    = string
  default = ""
}

variable "resource_policy_json" {
  description = <<-EOT
    Optional resource policy (JSON) to control access to the secret.
    Example (jsonencode):
    {
      Version = "2012-10-17",
      Statement = [{
        Effect = "Allow",
        Principal = { AWS = "arn:aws:iam::777777777771:role/some-role" },
        Action = ["secretsmanager:GetSecretValue"],
        Resource = "*"
      }]
    }
  EOT
  type    = string
  default = ""
}

variable "tags" {
  description = "Extra tags to apply to the secret."
  type        = map(string)
  default     = {}
}