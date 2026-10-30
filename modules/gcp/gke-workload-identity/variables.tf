variable "service_account_id" {
  description = "Service account ID."
  type        = string
}

variable "project" {
  description = "GCP project ID for service account."
  type        = string
  default     = null
}

variable "project_id" {
  description = "GCP project ID (for workload identity binding)."
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

variable "namespace" {
  description = "Kubernetes namespace for the KSA."
  type        = string
}

variable "ksa_name" {
  description = "Kubernetes service account name."
  type        = string
}

variable "roles" {
  description = "List of IAM roles to grant to the service account."
  type        = list(string)
  default     = []
}
