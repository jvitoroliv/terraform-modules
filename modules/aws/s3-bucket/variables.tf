variable "name" {
  description = "S3 bucket name (must be globally unique)."
  type        = string
}

variable "force_destroy" {
  description = "Force destroy even if bucket has objects (useful for ephemeral envs)."
  type        = bool
  default     = true
}

variable "block_public_access" {
  description = "Block all forms of public access."
  type        = bool
  default     = true
}

variable "versioning" {
  description = "Enable bucket versioning."
  type        = bool
  default     = false
}

variable "server_side_encryption" {
  description = "Enable default server-side encryption with S3-managed keys."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Extra tags for the bucket."
  type        = map(string)
  default     = {}
}