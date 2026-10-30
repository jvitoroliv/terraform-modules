variable "name" {
  description = "Name of the target HTTPS proxy."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the target HTTPS proxy."
  type        = string
  default     = ""
}

variable "url_map" {
  description = "URL map self_link to attach to the proxy."
  type        = string
}

variable "ssl_certificates" {
  description = "List of SSL certificate self_links."
  type        = list(string)
  default     = []
}

variable "certificate_map" {
  description = "Certificate Map self_link (alternative to ssl_certificates)."
  type        = string
  default     = null
}

variable "proxy_bind" {
  description = "Enable proxy bind for the target proxy."
  type        = bool
  default     = false
}

variable "quic_override" {
  description = "QUIC override policy (NONE, ENABLE, DISABLE)."
  type        = string
  default     = "NONE"

  validation {
    condition     = contains(["NONE", "ENABLE", "DISABLE"], var.quic_override)
    error_message = "quic_override must be one of: NONE, ENABLE, DISABLE."
  }
}

variable "ssl_policy" {
  description = "SSL policy self_link."
  type        = string
  default     = null
}

variable "http_keep_alive_timeout_sec" {
  description = "HTTP keep alive timeout in seconds."
  type        = number
  default     = 600
}

variable "labels" {
  description = "Labels to apply to the target HTTPS proxy."
  type        = map(string)
  default     = {}
}
