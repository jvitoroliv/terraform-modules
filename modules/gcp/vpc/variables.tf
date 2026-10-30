variable "name" {
  description = "Name of the VPC network."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "auto_create_subnetworks" {
  description = "Whether to automatically create subnetworks in each region."
  type        = bool
  default     = false
}

variable "routing_mode" {
  description = "Network routing mode: REGIONAL or GLOBAL."
  type        = string
  default     = "REGIONAL"

  validation {
    condition     = contains(["REGIONAL", "GLOBAL"], var.routing_mode)
    error_message = "routing_mode must be REGIONAL or GLOBAL."
  }
}

variable "mtu" {
  description = "Maximum Transmission Unit in bytes (1460-1500)."
  type        = number
  default     = 1460

  validation {
    condition     = var.mtu >= 1460 && var.mtu <= 1500
    error_message = "mtu must be between 1460 and 1500."
  }
}

variable "description" {
  description = "Description of the VPC network."
  type        = string
  default     = ""
}

variable "delete_default_routes_on_create" {
  description = "Delete default routes (0.0.0.0/0) on VPC creation."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to the VPC."
  type        = map(string)
  default     = {}
}
