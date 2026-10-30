variable "name" {
  description = "Name prefix for all resources."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the load balancer."
  type        = string
  default     = ""
}

variable "create_ip_address" {
  description = "Whether to create a new static IP address."
  type        = bool
  default     = true
}

variable "ip_address" {
  description = "Existing IP address to use (requires create_ip_address = false)."
  type        = string
  default     = null
}

variable "ip_version" {
  description = "IP version for the address: IPV4 or IPV6."
  type        = string
  default     = "IPV4"
}

variable "port_range" {
  description = "Port range for the forwarding rule (e.g., '443' or '80-443')."
  type        = string
}

variable "port_name" {
  description = "Named port on the backend instances."
  type        = string
  default     = null
}

variable "backends" {
  description = <<-EOT
    List of backend configurations:
    [
      {
        group           = "instance-group-self-link"
        balancing_mode  = "UTILIZATION"
        capacity_scaler = 1.0
        max_utilization = 0.8
      }
    ]
  EOT
  type = list(object({
    group                 = string
    balancing_mode        = optional(string)
    capacity_scaler       = optional(number)
    max_utilization       = optional(number)
    max_connections       = optional(number)
    max_rate              = optional(number)
    max_rate_per_instance = optional(number)
  }))
}

variable "health_checks" {
  description = "List of health check self_links."
  type        = list(string)
}

variable "timeout_sec" {
  description = "Backend service timeout in seconds."
  type        = number
  default     = 30
}

variable "connection_draining_timeout_sec" {
  description = "Connection draining timeout in seconds."
  type        = number
  default     = 300
}

variable "session_affinity" {
  description = "Session affinity: NONE, CLIENT_IP, CLIENT_IP_PORT_PROTO, etc."
  type        = string
  default     = "NONE"
}

variable "proxy_header" {
  description = "Proxy protocol header: NONE or PROXY_V1."
  type        = string
  default     = "NONE"
}

variable "enable_ssl" {
  description = "Enable SSL/TLS termination (uses SSL Proxy instead of TCP Proxy)."
  type        = bool
  default     = false
}

variable "ssl_certificates" {
  description = "List of SSL certificate self_links (required if enable_ssl = true)."
  type        = list(string)
  default     = []
}

variable "ssl_policy" {
  description = "SSL policy self_link for the SSL proxy."
  type        = string
  default     = null
}

variable "enable_logging" {
  description = "Enable logging for the backend service."
  type        = bool
  default     = false
}

variable "log_sample_rate" {
  description = "Sampling rate for logs (0.0 to 1.0)."
  type        = number
  default     = 1.0
}

variable "labels" {
  description = "Labels to apply to resources."
  type        = map(string)
  default     = {}
}
