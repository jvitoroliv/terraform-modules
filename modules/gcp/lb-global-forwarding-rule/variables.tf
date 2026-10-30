variable "name" {
  description = "Name of the global forwarding rule."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the forwarding rule."
  type        = string
  default     = ""
}

variable "target" {
  description = "Target proxy self_link (target HTTP or HTTPS proxy)."
  type        = string
}

variable "port_range" {
  description = "Port range for the forwarding rule (e.g., 80, 443, 8080-8089)."
  type        = string
  default     = "80"
}

variable "ip_protocol" {
  description = "IP protocol (TCP, UDP, ESP, AH, SCTP, ICMP)."
  type        = string
  default     = "TCP"

  validation {
    condition     = contains(["TCP", "UDP", "ESP", "AH", "SCTP", "ICMP"], var.ip_protocol)
    error_message = "ip_protocol must be one of: TCP, UDP, ESP, AH, SCTP, ICMP."
  }
}

variable "ip_address" {
  description = "Static IP address for the forwarding rule."
  type        = string
  default     = null
}

variable "load_balancing_scheme" {
  description = "Load balancing scheme (EXTERNAL, EXTERNAL_MANAGED, INTERNAL_MANAGED, INTERNAL_SELF_MANAGED)."
  type        = string
  default     = "EXTERNAL"

  validation {
    condition     = contains(["EXTERNAL", "EXTERNAL_MANAGED", "INTERNAL_MANAGED", "INTERNAL_SELF_MANAGED"], var.load_balancing_scheme)
    error_message = "Invalid load balancing scheme."
  }
}

variable "metadata_filters" {
  description = "List of metadata filters for Traffic Director."
  type = list(object({
    filter_match_criteria = string
    filter_labels = list(object({
      name  = string
      value = string
    }))
  }))
  default = []
}

variable "labels" {
  description = "Labels to apply to the forwarding rule."
  type        = map(string)
  default     = {}
}
