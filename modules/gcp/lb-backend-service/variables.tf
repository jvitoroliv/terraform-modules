variable "name" {
  description = "Name of the backend service."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the backend service."
  type        = string
  default     = ""
}

variable "protocol" {
  description = "Protocol for the backend service (HTTP, HTTPS, HTTP2, TCP, SSL, UDP, GRPC)."
  type        = string
  default     = "HTTP"

  validation {
    condition     = contains(["HTTP", "HTTPS", "HTTP2", "TCP", "SSL", "UDP", "GRPC"], var.protocol)
    error_message = "Protocol must be one of: HTTP, HTTPS, HTTP2, TCP, SSL, UDP, GRPC."
  }
}

variable "port_name" {
  description = "Name of the backend port (e.g., http, https)."
  type        = string
  default     = "http"
}

variable "timeout_sec" {
  description = "Backend service timeout in seconds."
  type        = number
  default     = 30
}

variable "enable_cdn" {
  description = "Enable Cloud CDN for this backend service."
  type        = bool
  default     = false
}

variable "session_affinity" {
  description = "Session affinity option (NONE, CLIENT_IP, CLIENT_IP_PROTO, CLIENT_IP_PORT_PROTO, GENERATED_COOKIE, HEADER_FIELD, HTTP_COOKIE)."
  type        = string
  default     = "NONE"

  validation {
    condition     = contains(["NONE", "CLIENT_IP", "CLIENT_IP_PROTO", "CLIENT_IP_PORT_PROTO", "GENERATED_COOKIE", "HEADER_FIELD", "HTTP_COOKIE"], var.session_affinity)
    error_message = "Invalid session affinity option."
  }
}

variable "affinity_cookie_ttl_sec" {
  description = "Lifetime of cookies in seconds (only for GENERATED_COOKIE affinity)."
  type        = number
  default     = 0
}

variable "connection_draining_timeout_sec" {
  description = "Time for which instance will drain connections when instance is removed from backend."
  type        = number
  default     = 300
}

variable "load_balancing_scheme" {
  description = "Load balancing scheme (EXTERNAL, EXTERNAL_MANAGED, INTERNAL, INTERNAL_MANAGED, INTERNAL_SELF_MANAGED)."
  type        = string
  default     = "EXTERNAL"

  validation {
    condition     = contains(["EXTERNAL", "EXTERNAL_MANAGED", "INTERNAL", "INTERNAL_MANAGED", "INTERNAL_SELF_MANAGED"], var.load_balancing_scheme)
    error_message = "Invalid load balancing scheme."
  }
}

variable "health_checks" {
  description = "List of health check self_links."
  type        = list(string)
}

variable "backends" {
  description = "List of backend configurations."
  type = list(object({
    group                        = string
    balancing_mode               = optional(string, "UTILIZATION")
    capacity_scaler              = optional(number, 1.0)
    max_utilization              = optional(number, 0.8)
    max_rate                     = optional(number)
    max_rate_per_instance        = optional(number)
    max_connections              = optional(number)
    max_connections_per_instance = optional(number)
  }))
  default = []
}

variable "cdn_policy" {
  description = "Cloud CDN policy configuration."
  type = object({
    cache_mode                   = optional(string, "CACHE_ALL_STATIC")
    default_ttl                  = optional(number, 3600)
    max_ttl                      = optional(number, 86400)
    client_ttl                   = optional(number, 3600)
    negative_caching             = optional(bool, false)
    serve_while_stale            = optional(number, 0)
    signed_url_cache_max_age_sec = optional(number, 0)
    cache_key_policy = optional(object({
      include_host           = optional(bool, true)
      include_protocol       = optional(bool, true)
      include_query_string   = optional(bool, true)
      query_string_whitelist = optional(list(string))
      query_string_blacklist = optional(list(string))
    }))
  })
  default = null
}

variable "iap" {
  description = "Identity-Aware Proxy configuration."
  type = object({
    oauth2_client_id     = string
    oauth2_client_secret = string
  })
  default = null
}

variable "enable_logging" {
  description = "Enable access logging for the backend service."
  type        = bool
  default     = false
}

variable "log_sample_rate" {
  description = "Sampling rate for access logs (0.0 to 1.0)."
  type        = number
  default     = 1.0

  validation {
    condition     = var.log_sample_rate >= 0.0 && var.log_sample_rate <= 1.0
    error_message = "Log sample rate must be between 0.0 and 1.0."
  }
}

variable "outlier_detection" {
  description = "Outlier detection configuration for circuit breaking."
  type = object({
    consecutive_errors                    = optional(number, 5)
    consecutive_gateway_failure           = optional(number, 5)
    enforcing_consecutive_errors          = optional(number, 100)
    enforcing_consecutive_gateway_failure = optional(number, 0)
    enforcing_success_rate                = optional(number, 0)
    max_ejection_percent                  = optional(number, 10)
    success_rate_minimum_hosts            = optional(number, 5)
    success_rate_request_volume           = optional(number, 100)
    success_rate_stdev_factor             = optional(number, 1900)
    base_ejection_time = optional(object({
      seconds = number
      nanos   = optional(number, 0)
    }))
    interval = optional(object({
      seconds = number
      nanos   = optional(number, 0)
    }))
  })
  default = null
}

variable "circuit_breakers" {
  description = "Circuit breaker configuration."
  type = object({
    max_requests_per_connection = optional(number)
    max_connections             = optional(number)
    max_pending_requests        = optional(number)
    max_requests                = optional(number)
    max_retries                 = optional(number)
  })
  default = null
}

variable "consistent_hash" {
  description = "Consistent hash-based load balancing configuration."
  type = object({
    http_header_name  = optional(string)
    minimum_ring_size = optional(number, 1024)
    http_cookie = optional(object({
      name = string
      path = optional(string)
      ttl = optional(object({
        seconds = number
        nanos   = optional(number, 0)
      }))
    }))
  })
  default = null
}

variable "custom_request_headers" {
  description = "Custom headers to add to requests (format: 'Header-Name: value')."
  type        = list(string)
  default     = null
}

variable "custom_response_headers" {
  description = "Custom headers to add to responses (format: 'Header-Name: value')."
  type        = list(string)
  default     = null
}

variable "locality_lb_policy" {
  description = "Locality load balancing policy (ROUND_ROBIN, LEAST_REQUEST, RING_HASH, RANDOM, MAGLEV, WEIGHTED_MAGLEV)."
  type        = string
  default     = null
}

variable "security_policy" {
  description = "Cloud Armor security policy self_link."
  type        = string
  default     = null
}

variable "security_settings" {
  description = "Security settings for backend service."
  type = object({
    client_tls_policy = string
    subject_alt_names = optional(list(string))
  })
  default = null
}

variable "labels" {
  description = "Labels to apply to the backend service."
  type        = map(string)
  default     = {}
}
