variable "name" {
  description = "Name of the Cloud Storage bucket (globally unique)."
  type        = string
}

variable "location" {
  description = "GCS bucket location (region or multi-region)."
  type        = string
  default     = "US"
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "storage_class" {
  description = "Storage class: STANDARD, NEARLINE, COLDLINE, ARCHIVE."
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "storage_class must be STANDARD, NEARLINE, COLDLINE, or ARCHIVE."
  }
}

variable "force_destroy" {
  description = "Delete bucket even if it contains objects."
  type        = bool
  default     = false
}

variable "uniform_bucket_level_access" {
  description = "Enable uniform bucket-level access (recommended)."
  type        = bool
  default     = true
}

variable "versioning_enabled" {
  description = "Enable object versioning."
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  description = "Lifecycle rules for object management."
  type = list(object({
    action = object({
      type          = string
      storage_class = optional(string)
    })
    condition = object({
      age                   = optional(number)
      created_before        = optional(string)
      num_newer_versions    = optional(number)
      matches_storage_class = optional(list(string))
    })
  }))
  default = []
}

variable "encryption_key" {
  description = "KMS key for bucket encryption (optional)."
  type        = string
  default     = null
}

variable "cors_config" {
  description = "CORS configuration for the bucket."
  type = object({
    origin          = list(string)
    method          = list(string)
    response_header = optional(list(string))
    max_age_seconds = optional(number)
  })
  default = null
}

variable "labels" {
  description = "Labels to apply to the bucket."
  type        = map(string)
  default     = {}
}
