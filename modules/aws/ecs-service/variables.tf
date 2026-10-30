variable "name" {
  description = "ECS service name."
  type        = string
}

variable "cluster_arn" {
  description = "ECS cluster ARN where the service will run."
  type        = string
}

variable "task_definition" {
  description = "Task definition ARN (with revision) to run."
  type        = string
}

variable "desired_count" {
  description = "Number of tasks to run."
  type        = number
  default     = 1
}

variable "launch_type" {
  description = "LAUNCH TYPE: FARGATE or EC2 (omit when using capacity providers)."
  type        = string
  default     = "FARGATE"
}

variable "capacity_provider_strategy" {
  description = <<-EOT
    Optional capacity provider strategy. Example:
    [
      { capacity_provider = "FARGATE_SPOT", weight = 1, base = 0 }
    ]
    When set, omit launch_type.
  EOT
  type = list(object({
    capacity_provider = string
    weight            = optional(number)
    base              = optional(number)
  }))
  default = null
}

variable "platform_version" {
  description = "Fargate platform version (e.g., 1.4.0 or LATEST)."
  type        = string
  default     = "LATEST"
}

variable "enable_execute_command" {
  description = "Enable ECS Exec for troubleshooting."
  type        = bool
  default     = true
}

variable "network_configuration" {
  description = <<-EOT
    VPC networking for awsvpc mode:
    {
      subnets         = ["subnet-..."]
      security_groups = ["sg-..."]
      assign_public_ip= true
    }
  EOT
  type = object({
    subnets         = list(string)
    security_groups = list(string)
    assign_public_ip= bool
  })
}

variable "load_balancer" {
  description = <<-EOT
    Optional single target group attachment:
    {
      target_group_arn = "arn:aws:elasticloadbalancing:..."
      container_name   = "app"
      container_port   = 3000
    }
  EOT
  type = object({
    target_group_arn = string
    container_name   = string
    container_port   = number
  })
  default = null
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum healthy percent during deployment."
  type        = number
  default     = 0
}

variable "deployment_maximum_percent" {
  description = "Maximum percent during deployment."
  type        = number
  default     = 200
}

variable "propagate_tags" {
  description = "Propagate tags from SERVICE or TASK_DEFINITION."
  type        = string
  default     = "SERVICE"
}

variable "force_new_deployment" {
  description = "Force a new deployment on apply even if nothing changed."
  type        = bool
  default     = false
}

variable "wait_for_steady_state" {
  description = "Block until the service reaches a steady state (useful in CI)."
  type        = bool
  default     = true
}

variable "service_registries" {
  description = <<-EOT
    Optional service registries for service discovery:
    [
      {
        registry_arn   = "arn:aws:servicediscovery:..."
        port           = 3000  # Optional
        container_name = "app" # Optional
        container_port = 3000  # Optional
      }
    ]
  EOT
  type = list(object({
    registry_arn   = string
    port           = optional(number)
    container_name = optional(string)
    container_port = optional(number)
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to the service."
  type        = map(string)
  default     = {}
}