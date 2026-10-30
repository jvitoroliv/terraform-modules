variable "name" {
  description = "Name of the service discovery service"
  type        = string
}

variable "namespace_id" {
  description = "The ID of the namespace to use for DNS configuration"
  type        = string
}

variable "description" {
  description = "Description for the service discovery service"
  type        = string
  default     = ""
}

variable "dns_ttl" {
  description = "Amount of time, in seconds, that you want DNS resolvers to cache the settings for this record"
  type        = number
  default     = 10
}

variable "dns_type" {
  description = "Type of the resource, which indicates the type of value that Route 53 returns in response to DNS queries"
  type        = string
  default     = "A"
  validation {
    condition     = contains(["A", "AAAA", "CNAME", "SRV"], var.dns_type)
    error_message = "DNS type must be one of: A, AAAA, CNAME, SRV."
  }
}

variable "routing_policy" {
  description = "Routing policy that you want to apply to all DNS records"
  type        = string
  default     = "MULTIVALUE"
  validation {
    condition     = contains(["MULTIVALUE", "WEIGHTED"], var.routing_policy)
    error_message = "Routing policy must be MULTIVALUE or WEIGHTED."
  }
}

variable "failure_threshold" {
  description = "Number of consecutive health checks that an endpoint must pass or fail"
  type        = number
  default     = 1
}

variable "health_check_grace_period_seconds" {
  description = "Amount of time that you want Cloud Map to wait after receiving an UpdateInstanceCustomHealthStatus request"
  type        = number
  default     = 30
}

variable "health_check_custom_config" {
  description = "Information about an optional custom health check"
  type = object({
    failure_threshold = optional(number, 1)
  })
  default = null
}

variable "tags" {
  description = "A map of tags to assign to the service"
  type        = map(string)
  default     = {}
}