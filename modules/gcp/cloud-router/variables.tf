variable "name" {
  description = "Name of the Cloud Router."
  type        = string
}

variable "network" {
  description = "VPC network self link."
  type        = string
}

variable "region" {
  description = "GCP region for the Cloud Router."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the Cloud Router."
  type        = string
  default     = ""
}

variable "bgp_config" {
  description = <<-EOT
    Optional BGP configuration:
    {
      asn               = 64512
      advertise_mode    = "CUSTOM"
      advertised_groups = ["ALL_SUBNETS"]
    }
  EOT
  type = object({
    asn               = number
    advertise_mode    = optional(string)
    advertised_groups = optional(list(string))
  })
  default = null
}
