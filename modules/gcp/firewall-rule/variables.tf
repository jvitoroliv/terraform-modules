variable "name" {
  description = "Name of the firewall rule."
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
  description = "Description of the firewall rule."
  type        = string
  default     = ""
}

variable "direction" {
  description = "Direction of traffic: INGRESS or EGRESS."
  type        = string
  default     = "INGRESS"

  validation {
    condition     = contains(["INGRESS", "EGRESS"], var.direction)
    error_message = "direction must be INGRESS or EGRESS."
  }
}

variable "priority" {
  description = "Priority of the rule (0-65535, lower is higher priority)."
  type        = number
  default     = 1000

  validation {
    condition     = var.priority >= 0 && var.priority <= 65535
    error_message = "priority must be between 0 and 65535."
  }
}

variable "source_ranges" {
  description = "Source IP CIDR ranges (for INGRESS)."
  type        = list(string)
  default     = []
}

variable "destination_ranges" {
  description = "Destination IP CIDR ranges (for EGRESS)."
  type        = list(string)
  default     = []
}

variable "source_tags" {
  description = "Source network tags."
  type        = list(string)
  default     = []
}

variable "target_tags" {
  description = "Target network tags."
  type        = list(string)
  default     = []
}

variable "source_service_accounts" {
  description = "Source service accounts."
  type        = list(string)
  default     = []
}

variable "target_service_accounts" {
  description = "Target service accounts."
  type        = list(string)
  default     = []
}

variable "allow_rules" {
  description = <<-EOT
    Allow rules:
    [
      {
        protocol = "tcp"
        ports    = ["80", "443"]
      }
    ]
  EOT
  type = list(object({
    protocol = string
    ports    = optional(list(string))
  }))
  default = []
}

variable "deny_rules" {
  description = <<-EOT
    Deny rules:
    [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
  EOT
  type = list(object({
    protocol = string
    ports    = optional(list(string))
  }))
  default = []
}

variable "disabled" {
  description = "Disable the firewall rule."
  type        = bool
  default     = false
}
