variable "name" {
  description = "Name of the subnet."
  type        = string
}

variable "ip_cidr_range" {
  description = "Primary IP CIDR range for the subnet."
  type        = string
}

variable "region" {
  description = "GCP region for the subnet."
  type        = string
}

variable "network" {
  description = "VPC network self link."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the subnet."
  type        = string
  default     = ""
}

variable "private_ip_google_access" {
  description = "Enable private Google API access."
  type        = bool
  default     = true
}

variable "log_config" {
  description = <<-EOT
    Optional VPC flow logs configuration:
    {
      aggregation_interval = "INTERVAL_5_SEC"
      flow_sampling        = 0.5
      metadata             = "INCLUDE_ALL_METADATA"
    }
  EOT
  type = object({
    aggregation_interval = string
    flow_sampling        = number
    metadata             = string
  })
  default = null
}

variable "secondary_ip_ranges" {
  description = <<-EOT
    Secondary IP ranges for GKE pods/services:
    [
      {
        range_name    = "pods"
        ip_cidr_range = "10.1.0.0/16"
      }
    ]
  EOT
  type = list(object({
    range_name    = string
    ip_cidr_range = string
  }))
  default = []
}
