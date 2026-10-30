variable "name" {
  description = "Name of the Application Load Balancer."
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs where the ALB will be placed (typically public subnets)."
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the ALB."
  type        = list(string)
  default     = []
}

variable "internal" {
  description = "Whether the ALB is internal. Defaults to internet-facing."
  type        = bool
  default     = false
}

variable "ip_address_type" {
  description = "IP address type: ipv4 or dualstack."
  type        = string
  default     = "ipv4"
  validation {
    condition     = contains(["ipv4", "dualstack"], var.ip_address_type)
    error_message = "IP address type must be 'ipv4' or 'dualstack'."
  }
}

variable "idle_timeout" {
  description = "Idle timeout in seconds."
  type        = number
  default     = 60
}

variable "enable_http2" {
  description = "Enable HTTP/2 on the ALB."
  type        = bool
  default     = true
}

variable "drop_invalid_header_fields" {
  description = "Drop invalid header fields to mitigate malformed requests."
  type        = bool
  default     = true
}

variable "desync_mitigation_mode" {
  description = "Desync mitigation mode (defensive, strictest, monitor)."
  type        = string
  default     = "defensive"
  validation {
    condition     = contains(["defensive", "strictest", "monitor"], var.desync_mitigation_mode)
    error_message = "Desync mitigation mode must be one of: defensive, strictest, monitor."
  }
}

variable "deletion_protection" {
  description = "Enable deletion protection on the ALB."
  type        = bool
  default     = false
}

variable "access_logs" {
  description = <<-EOT
    Optional access logging configuration. Example:
    {
      enabled = true,
      bucket  = "my-logs-bucket",
      prefix  = "alb/"
    }
  EOT
  type = object({
    enabled = bool
    bucket  = string
    prefix  = optional(string, "")
  })
  default = null
}

variable "tags" {
  description = "Extra tags to merge into the ALB."
  type        = map(string)
  default     = {}
}
