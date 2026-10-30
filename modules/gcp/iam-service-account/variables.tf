variable "account_id" {
  description = "Service account ID (unique within project)."
  type        = string
}

variable "display_name" {
  description = "Display name for the service account."
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the service account."
  type        = string
  default     = ""
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}
