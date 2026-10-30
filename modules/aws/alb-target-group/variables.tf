variable "name" {
  description = "Target group name."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the target group will be created."
  type        = string
}

variable "port" {
  description = "Port on which targets receive traffic."
  type        = number
}

variable "protocol" {
  description = "Protocol for routing (HTTP or HTTPS)."
  type        = string
  default     = "HTTP"
  validation {
    condition     = contains(["HTTP", "HTTPS"], var.protocol)
    error_message = "Protocol must be HTTP or HTTPS."
  }
}

variable "target_type" {
  description = "Type of targets: instance, ip, or lambda."
  type        = string
  default     = "ip"
  validation {
    condition     = contains(["instance", "ip", "lambda"], var.target_type)
    error_message = "Target type must be one of: instance, ip, lambda."
  }
}

variable "protocol_version" {
  description = "Protocol version for HTTP/HTTPS target groups (e.g., HTTP1, HTTP2, GRPC)."
  type        = string
  default     = "HTTP1"
}

variable "deregistration_delay" {
  description = "Time in seconds for deregistration delay."
  type        = number
  default     = 10
}

variable "health_check" {
  description = <<-EOT
    Health check configuration. Example:
    {
      path                = "/healthz"
      healthy_threshold   = 2
      unhealthy_threshold = 3
      interval            = 15
      timeout             = 5
      matcher             = "200-399"
      port                = "traffic-port"
      protocol            = "HTTP"
    }
  EOT
  type = object({
    path                = optional(string, "/")
    healthy_threshold   = optional(number, 2)
    unhealthy_threshold = optional(number, 3)
    interval            = optional(number, 15)
    timeout             = optional(number, 5)
    matcher             = optional(string, "200-399")
    port                = optional(string, "traffic-port")
    protocol            = optional(string, "HTTP")
  })
  default = {}
}

variable "stickiness" {
  description = <<-EOT
    Optional stickiness settings. Example:
    {
      enabled = true
      type    = "lb_cookie" # or "app_cookie"
      cookie_duration = 300
      cookie_name     = null # only for app_cookie
    }
  EOT
  type = object({
    enabled         = bool
    type            = string
    cookie_duration = optional(number)
    cookie_name     = optional(string)
  })
  default = null
}

variable "tags" {
  description = "Extra tags to merge into the target group."
  type        = map(string)
  default     = {}
}
