variable "secret" {
  description = "Secret name or ID to create version for."
  type        = string
}

variable "secret_data" {
  description = "Secret data payload (sensitive)."
  type        = string
  sensitive   = true
}

variable "enabled" {
  description = "Enable the secret version."
  type        = bool
  default     = true
}

variable "deletion_policy" {
  description = "Deletion policy (ABANDON, DISABLE, DELETE)."
  type        = string
  default     = "DELETE"

  validation {
    condition     = contains(["ABANDON", "DISABLE", "DELETE"], var.deletion_policy)
    error_message = "deletion_policy must be ABANDON, DISABLE, or DELETE."
  }
}

variable "is_secret_data_base64" {
  description = "Treat secret_data as base64 encoded."
  type        = bool
  default     = null
}
