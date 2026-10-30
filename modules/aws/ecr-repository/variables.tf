variable "name" {
  description = "ECR repository name (e.g., gameplatform/server)."
  type        = string
}

variable "image_tag_mutability" {
  description = "Tag mutability: MUTABLE or IMMUTABLE."
  type        = string
  default     = "IMMUTABLE"
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "Image tag mutability must be MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Enable ECR image scanning on push."
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "ECR encryption type: AES256 or KMS."
  type        = string
  default     = "AES256"
  validation {
    condition     = contains(["AES256", "KMS"], var.encryption_type)
    error_message = "Encryption type must be AES256 or KMS."
  }
}

variable "kms_key" {
  description = "KMS key ARN for encryption (required if encryption_type = KMS)."
  type        = string
  default     = ""
}

variable "force_delete" {
  description = "Force delete repository even if images exist (useful in PR envs)."
  type        = bool
  default     = true
}

variable "lifecycle_keep_last" {
  description = <<-EOT
    Keep only the last N images (per repo) to control costs. If 0, lifecycle is not created.
    Note: This is a simple 'most recent N' rule for ANY tag; tune with lifecycle_policy_json if needed.
  EOT
  type    = number
  default = 10
}

variable "lifecycle_policy_json" {
  description = "Optional raw lifecycle policy JSON (overrides lifecycle_keep_last if provided)."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Extra tags to attach to the repository."
  type        = map(string)
  default     = {}
}
