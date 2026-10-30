variable "name" {
  description = "Name of the health check."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the health check."
  type        = string
  default     = ""
}

variable "type" {
  description = "Type of health check: TCP, HTTP, HTTPS, GRPC, or SSL."
  type        = string
  default     = "TCP"

  validation {
    condition     = contains(["TCP", "HTTP", "HTTPS", "GRPC", "SSL"], var.type)
    error_message = "Type must be one of: TCP, HTTP, HTTPS, GRPC, SSL."
  }
}

variable "check_interval_sec" {
  description = "How often (in seconds) to send a health check."
  type        = number
  default     = 5
}

variable "timeout_sec" {
  description = "How long (in seconds) to wait for a response."
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of consecutive successes required to mark healthy."
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Number of consecutive failures required to mark unhealthy."
  type        = number
  default     = 2
}

variable "port" {
  description = "Port number for the health check."
  type        = number
  default     = null
}

variable "port_name" {
  description = "Port name as defined in InstanceGroup#NamedPort#name."
  type        = string
  default     = null
}

variable "port_specification" {
  description = "How port is selected for health checking: USE_FIXED_PORT, USE_NAMED_PORT, USE_SERVING_PORT."
  type        = string
  default     = "USE_FIXED_PORT"
}

variable "proxy_header" {
  description = "Proxy header type: NONE or PROXY_V1."
  type        = string
  default     = "NONE"
}

variable "tcp_request" {
  description = "Request data to send for TCP/SSL health checks."
  type        = string
  default     = null
}

variable "tcp_response" {
  description = "Expected response for TCP/SSL health checks."
  type        = string
  default     = null
}

variable "http_host" {
  description = "Host header value for HTTP/HTTPS health checks."
  type        = string
  default     = null
}

variable "http_request_path" {
  description = "Request path for HTTP/HTTPS health checks."
  type        = string
  default     = "/"
}

variable "http_response" {
  description = "Expected response body for HTTP/HTTPS health checks."
  type        = string
  default     = null
}

variable "grpc_service_name" {
  description = "Service name for gRPC health checks."
  type        = string
  default     = null
}

variable "log_config_enable" {
  description = "Enable logging for health check probes."
  type        = bool
  default     = false
}
