variable "name" {
  description = "Name of the DNS managed zone (must be unique)."
  type        = string
}

variable "dns_name" {
  description = "DNS name of the zone (must end with a dot, e.g., 'example.com.')."
  type        = string
}

variable "description" {
  description = "Description of the DNS zone."
  type        = string
  default     = ""
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "visibility" {
  description = "Zone visibility: public or private."
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "private"], var.visibility)
    error_message = "visibility must be public or private."
  }
}

variable "private_visibility_config" {
  description = <<-EOT
    Private zone configuration:
    {
      networks = [
        { network_url = "https://www.googleapis.com/compute/v1/projects/PROJECT/global/networks/VPC" }
      ]
    }
  EOT
  type = object({
    networks = list(object({
      network_url = string
    }))
  })
  default = null
}

variable "dnssec_config" {
  description = <<-EOT
    DNSSEC configuration:
    {
      state         = "on"
      non_existence = "nsec3"
    }
  EOT
  type = object({
    state         = string
    non_existence = optional(string)
  })
  default = null
}

variable "labels" {
  description = "Labels to apply to the DNS zone."
  type        = map(string)
  default     = {}
}
