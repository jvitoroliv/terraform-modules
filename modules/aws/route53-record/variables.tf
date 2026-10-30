variable "zone_id" {
  description = "Route53 hosted zone ID where the record will be created."
  type        = string
}

variable "name" {
  description = "Record name (can be relative or FQDN)."
  type        = string
}

variable "type" {
  description = "Record type (A, AAAA, CNAME, TXT, etc)."
  type        = string
}

variable "ttl" {
  description = "TTL for the record (in seconds)."
  type        = number
  default     = 300
}

variable "records" {
  description = "List of record values. Required for simple records."
  type        = list(string)
  default     = []
}

variable "alias" {
  description = <<-EOT
    Optional ALIAS record. Example:
    {
      name                   = "dualstack.alb-dns.amazonaws.com"
      zone_id                = "Z35SXDOTRQ7X7K"
      evaluate_target_health = true
    }
  EOT
  type = object({
    name                   = string
    zone_id                = string
    evaluate_target_health = bool
  })
  default = null
}

variable "allow_overwrite" {
  description = "Allow overwriting an existing record with the same name/type."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for the record (Route53 doesn’t support tags directly, kept for consistency)."
  type        = map(string)
  default     = {}
}