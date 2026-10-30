variable "domain_name" {
  description = "Primary domain name for the certificate (e.g., *.dev.example.com)."
  type        = string
}

variable "subject_alternative_names" {
  description = "Optional SANs to include in the certificate."
  type        = list(string)
  default     = []
}

variable "validation_dns" {
  description = <<-EOT
    DNS validation settings.
    hosted_zone_id: Route53 hosted zone ID where validation records will be created.
  EOT
  type = object({
    hosted_zone_id = string
  })
}

variable "tags" {
  description = "Extra tags to merge into the ACM certificate."
  type        = map(string)
  default     = {}
}