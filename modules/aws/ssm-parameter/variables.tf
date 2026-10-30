variable "name" {
  description = "Name of the SSM Parameter (full path, e.g. /gameplatform/pr-123/db/password)."
  type        = string
}

variable "type" {
  description = "Type of the parameter: String | StringList | SecureString."
  type        = string
  default     = "SecureString"
  validation {
    condition     = contains(["String", "StringList", "SecureString"], var.type)
    error_message = "Type must be one of: String, StringList, or SecureString."
  }
}

variable "value" {
  description = <<-EOT
    Parameter value. Keep empty to create the parameter without a value.
    For SecureString, provide via pipeline or TF_VAR_value.
  EOT
  type    = string
  default = ""
}

variable "overwrite" {
  description = "Allow overwriting an existing parameter."
  type        = bool
  default     = true
}

variable "tier" {
  description = "Parameter tier: Standard, Advanced, Intelligent-Tiering."
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Advanced", "Intelligent-Tiering"], var.tier)
    error_message = "Tier must be Standard, Advanced, or Intelligent-Tiering."
  }
}

variable "kms_key_id" {
  description = "KMS Key ID or ARN used for SecureString. If empty, AWS-managed key is used."
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the parameter."
  type        = string
  default     = ""
}

variable "allowed_pattern" {
  description = "Optional regex to validate the parameter value."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags for the SSM parameter."
  type        = map(string)
  default     = {}
}
