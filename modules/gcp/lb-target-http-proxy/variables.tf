variable "name" {
  description = "Name of the target HTTP proxy."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the target HTTP proxy."
  type        = string
  default     = ""
}

variable "url_map" {
  description = "URL map self_link to attach to the proxy."
  type        = string
}

variable "proxy_bind" {
  description = "Enable proxy bind for the target proxy."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to the target HTTP proxy."
  type        = map(string)
  default     = {}
}
