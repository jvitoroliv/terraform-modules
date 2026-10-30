variable "name" {
  description = "DNS record name (must end with zone dns_name, e.g., 'www.example.com.')."
  type        = string
}

variable "type" {
  description = "DNS record type: A, AAAA, CNAME, MX, TXT, etc."
  type        = string
}

variable "ttl" {
  description = "Time to live in seconds."
  type        = number
  default     = 300
}

variable "managed_zone" {
  description = "Name of the managed zone."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "rrdatas" {
  description = "List of DNS record values (e.g., ['192.0.2.1'] for A record)."
  type        = list(string)
}
