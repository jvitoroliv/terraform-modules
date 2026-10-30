variable "load_balancer_arn" {
  description = "ARN of the ALB to attach this listener to."
  type        = string
}

variable "port" {
  description = "Listener port (e.g., 80 or 443)."
  type        = number
}

variable "protocol" {
  description = "Listener protocol (HTTP or HTTPS)."
  type        = string
  validation {
    condition     = contains(["HTTP", "HTTPS"], var.protocol)
    error_message = "Protocol must be HTTP or HTTPS."
  }
}

variable "certificate_arn" {
  description = "ACM certificate ARN (required for HTTPS)."
  type        = string
  default     = ""
}

variable "ssl_policy" {
  description = "TLS policy for HTTPS listeners."
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "default_action" {
  description = <<-EOT
    Default action for the listener.
    One of:
      - { type = "forward", target_group_arn = "arn:..." }
      - { type = "redirect", redirect = { port = "443", protocol = "HTTPS", status_code = "HTTP_301" } }
      - { type = "fixed-response", fixed_response = { content_type = "text/plain", message_body = "..." , status_code = "200" } }
  EOT
  type = object({
    type             = string
    target_group_arn = optional(string)
    redirect = optional(object({
      port        = string
      protocol    = string
      status_code = string
      host        = optional(string)
      path        = optional(string)
      query       = optional(string)
    }))
    fixed_response = optional(object({
      content_type = string
      message_body = optional(string)
      status_code  = string
    }))
  })
}

variable "rules" {
  description = <<-EOT
    Optional listener rules. Example:
    [
      {
        priority = 10
        host_headers = ["app-pr123.dev.example.com"]
        path_patterns = null
        target_group_arn = "arn:aws:elasticloadbalancing:..."
      }
    ]
  EOT
  type = list(object({
    priority         = number
    host_headers     = optional(list(string))
    path_patterns    = optional(list(string))
    http_headers     = optional(list(object({ name = string, values = list(string) })))
    target_group_arn = string
  }))
  default = []
}

variable "tags" {
  description = "Tags applied to created rule resources (listener itself doesn't support tags)."
  type        = map(string)
  default     = {}
}
