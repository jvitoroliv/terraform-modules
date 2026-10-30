variable "name" {
  description = "ECS cluster name."
  type        = string
}

variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights for the cluster."
  type        = bool
  default     = true
}

variable "default_capacity_providers" {
  description = <<-EOT
    Default capacity providers to associate with the cluster. Typical:
    ["FARGATE"] or ["FARGATE", "FARGATE_SPOT"].
  EOT
  type        = list(string)
  default     = ["FARGATE"]
  validation {
    condition     = alltrue([for p in var.default_capacity_providers : contains(["FARGATE", "FARGATE_SPOT"], p)])
    error_message = "Supported providers: FARGATE, FARGATE_SPOT."
  }
}

variable "default_capacity_provider_strategy" {
  description = <<-EOT
    Optional default strategy. Example:
    [
      { capacity_provider = "FARGATE_SPOT", weight = 1, base = 0 }
    ]
    If null, AWS will use provider defaults.
  EOT
  type = list(object({
    capacity_provider = string
    weight            = optional(number)
    base              = optional(number)
  }))
  default = []
}

variable "tags" {
  description = "Extra tags for the cluster."
  type        = map(string)
  default     = {}
}