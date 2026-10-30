variable "name" {
  description = "Name of the managed SSL certificate."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the SSL certificate."
  type        = string
  default     = ""
}

variable "domains" {
  description = "List of domains for the SSL certificate (max 100)."
  type        = list(string)

  validation {
    condition     = length(var.domains) > 0 && length(var.domains) <= 100
    error_message = "Domains list must contain 1-100 domains."
  }
}

variable "labels" {
  description = "Labels to apply to the SSL certificate."
  type        = map(string)
  default     = {}
}
