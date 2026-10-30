variable "name" {
  description = "Name of the Cloud NAT."
  type        = string
}

variable "router" {
  description = "Cloud Router name."
  type        = string
}

variable "region" {
  description = "GCP region for the Cloud NAT."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "nat_ip_allocate_option" {
  description = "How NAT IPs are allocated: AUTO_ONLY or MANUAL_ONLY."
  type        = string
  default     = "AUTO_ONLY"

  validation {
    condition     = contains(["AUTO_ONLY", "MANUAL_ONLY"], var.nat_ip_allocate_option)
    error_message = "nat_ip_allocate_option must be AUTO_ONLY or MANUAL_ONLY."
  }
}

variable "source_subnetwork_ip_ranges_to_nat" {
  description = "NAT source subnet ranges: ALL_SUBNETWORKS_ALL_IP_RANGES, ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, LIST_OF_SUBNETWORKS."
  type        = string
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  validation {
    condition     = contains(["ALL_SUBNETWORKS_ALL_IP_RANGES", "ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES", "LIST_OF_SUBNETWORKS"], var.source_subnetwork_ip_ranges_to_nat)
    error_message = "Invalid source_subnetwork_ip_ranges_to_nat value."
  }
}

variable "min_ports_per_vm" {
  description = "Minimum ports per VM."
  type        = number
  default     = 64
}

variable "max_ports_per_vm" {
  description = "Maximum ports per VM (when dynamic allocation enabled)."
  type        = number
  default     = null
}

variable "enable_dynamic_port_allocation" {
  description = "Enable dynamic port allocation."
  type        = bool
  default     = false
}

variable "enable_endpoint_independent_mapping" {
  description = "Enable endpoint independent mapping."
  type        = bool
  default     = true
}

variable "log_config" {
  description = <<-EOT
    Optional logging configuration:
    {
      enable = true
      filter = "ALL"
    }
  EOT
  type = object({
    enable = bool
    filter = string
  })
  default = null
}

variable "subnetworks" {
  description = <<-EOT
    List of subnetworks to NAT (when using LIST_OF_SUBNETWORKS):
    [
      {
        name                    = "subnet-1"
        source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
      }
    ]
  EOT
  type = list(object({
    name                    = string
    source_ip_ranges_to_nat = list(string)
  }))
  default = []
}
