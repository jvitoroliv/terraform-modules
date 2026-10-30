variable "secret_id" {
  description = "Secret ID (unique within project)."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "replication_policy" {
  description = "Replication policy (auto or user_managed)."
  type        = string
  default     = "auto"

  validation {
    condition     = contains(["auto", "user_managed"], var.replication_policy)
    error_message = "replication_policy must be 'auto' or 'user_managed'."
  }
}

variable "kms_key_name" {
  description = "KMS key name for automatic replication encryption."
  type        = string
  default     = null
}

variable "replicas" {
  description = "List of replica locations for user_managed replication."
  type = list(object({
    location     = string
    kms_key_name = optional(string)
  }))
  default = []
}

variable "topics" {
  description = "List of Pub/Sub topic names for notifications."
  type        = list(string)
  default     = []
}

variable "rotation" {
  description = "Secret rotation configuration."
  type = object({
    next_rotation_time = optional(string)
    rotation_period    = optional(string)
  })
  default = null
}

variable "expire_time" {
  description = "Timestamp when secret expires (RFC3339 format)."
  type        = string
  default     = null
}

variable "ttl" {
  description = "Time-to-live duration (e.g., '3600s', '1h')."
  type        = string
  default     = null
}

variable "annotations" {
  description = "Annotations for the secret."
  type        = map(string)
  default     = {}
}

variable "version_aliases" {
  description = "Mapping of version aliases to version numbers."
  type        = map(string)
  default     = {}
}

variable "version_destroy_ttl" {
  description = "Time to wait before destroying a secret version."
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels to apply to the secret."
  type        = map(string)
  default     = {}
}
