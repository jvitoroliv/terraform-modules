variable "listener_arn" {
  description = "ARN of the ALB listener"
  type        = string
}

variable "priority" {
  description = "Priority for the rule (1-50000). Leave null for auto-assignment"
  type        = number
  default     = null
}

variable "condition" {
  description = "Condition for the listener rule"
  type = object({
    host_header = optional(object({
      values = list(string)
    }))
    path_pattern = optional(object({
      values = list(string)
    }))
    http_header = optional(object({
      name   = string
      values = list(string)
    }))
    http_request_method = optional(object({
      values = list(string)
    }))
    query_string = optional(list(object({
      key   = optional(string)
      value = string
    })))
    source_ip = optional(object({
      values = list(string)
    }))
  })
}

variable "action" {
  description = "Action for the listener rule"
  type = object({
    type               = string
    target_group_arn   = optional(string)
    redirect           = optional(object({
      host        = optional(string)
      path        = optional(string)
      port        = optional(string)
      protocol    = optional(string)
      query       = optional(string)
      status_code = string
    }))
    fixed_response     = optional(object({
      content_type = string
      message_body = optional(string)
      status_code  = string
    }))
    forward           = optional(object({
      target_groups = list(object({
        arn    = string
        weight = optional(number, 100)
      }))
      stickiness = optional(object({
        enabled  = bool
        duration = number
      }))
    }))
  })
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}