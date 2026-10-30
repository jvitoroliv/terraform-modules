variable "name" {
  description = "Name of the URL map."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the URL map."
  type        = string
  default     = ""
}

variable "default_service" {
  description = "Default backend service for the URL map."
  type        = string
  default     = null
}

variable "host_rules" {
  description = "List of host rules for routing."
  type = list(object({
    hosts        = list(string)
    path_matcher = string
  }))
  default = []
}

variable "path_matchers" {
  description = "List of path matchers with routing rules."
  type        = any
  default     = []
}

variable "default_url_redirect" {
  description = "Default URL redirect configuration."
  type = object({
    host_redirect          = optional(string)
    path_redirect          = optional(string)
    prefix_redirect        = optional(string)
    redirect_response_code = optional(string, "MOVED_PERMANENTLY_DEFAULT")
    https_redirect         = optional(bool, false)
    strip_query            = optional(bool, false)
  })
  default = null
}

variable "tests" {
  description = "List of URL map tests."
  type = list(object({
    service     = string
    host        = string
    path        = string
    description = optional(string)
  }))
  default = []
}

variable "header_action" {
  description = "Header action configuration."
  type        = any
  default     = null
}

variable "default_route_action_weighted_backend_services" {
  description = "Weighted backend services for default route action."
  type = list(object({
    backend_service = string
    weight          = number
  }))
  default = []
}

variable "labels" {
  description = "Labels to apply to the URL map."
  type        = map(string)
  default     = {}
}
