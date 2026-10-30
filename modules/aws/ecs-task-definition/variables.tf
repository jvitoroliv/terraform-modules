variable "family" {
  description = "Task definition family name."
  type        = string
}

variable "network_mode" {
  description = "Network mode: awsvpc | bridge | host | none. For Fargate use awsvpc."
  type        = string
  default     = "awsvpc"
}

variable "requires_compatibilities" {
  description = "Compatibilities for the task (e.g., [\"FARGATE\"])."
  type        = list(string)
  default     = ["FARGATE"]
}

variable "cpu" {
  description = "Task-level CPU units. For Fargate pick approved combos (256, 512, 1024, 2048, 4096)."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Task-level memory (MB). For Fargate pick approved combos (512, 1024, 2048, ...)."
  type        = number
  default     = 512
}

variable "execution_role_arn" {
  description = "IAM role ARN for ECS task execution (pull from ECR, CloudWatch logs, SSM)."
  type        = string
}

variable "task_role_arn" {
  description = "IAM role ARN assumed by the running task (app permissions)."
  type        = string
}

variable "ephemeral_storage_size" {
  description = "Ephemeral storage size (GiB). Set >=21 to override default 20GiB. Fargate only."
  type        = number
  default     = 20
}

variable "container" {
  description = <<-EOT
    Single-container definition (legacy):
    {
      name              = "app"
      image             = "777777777771.dkr.ecr.sa-east-1.amazonaws.com/app:tag"
      port_mappings     = [{ container_port = 3000, host_port = 3000, protocol = "tcp" }]
      log_group_name    = "/project/env/app"
      environment       = { KEY = "value" }
      ssm_secret_paths  = ["/project/env/SECRET_A", "/project/env/SECRET_B"]
      essential         = true
    }
  EOT
  type = object({
    name             = string
    image            = string
    port_mappings    = list(object({
      container_port = number
      host_port      = number
      protocol       = string
    }))
    log_group_name   = string
    environment      = optional(map(string), {})
    ssm_secret_paths = optional(list(string), [])
    secrets          = optional(list(object({
      name      = string
      valueFrom = string
    })), [])
    essential        = optional(bool, true)
    command          = optional(list(string), [])
  })
  default = null
}

variable "containers" {
  description = <<-EOT
    Multi-container definition (recommended):
    [
      {
        name              = "app"
        image             = "777777777771.dkr.ecr.sa-east-1.amazonaws.com/app:tag"
        port_mappings     = [{ container_port = 3000, host_port = 3000, protocol = "tcp" }]
        log_group_name    = "/project/env/app"
        environment       = { KEY = "value" }
        ssm_secret_paths  = ["/project/env/SECRET_A", "/project/env/SECRET_B"]
        secrets           = [{ name = "SECRET", valueFrom = "arn:aws:secretsmanager:region:account:secret:name" }]
        essential         = true
      }
    ]
  EOT
  type = list(object({
    name             = string
    image            = string
    port_mappings    = list(object({
      container_port = number
      host_port      = number
      protocol       = string
    }))
    log_group_name   = string
    environment      = optional(map(string), {})
    ssm_secret_paths = optional(list(string), [])
    secrets          = optional(list(object({
      name      = string
      valueFrom = string
    })), [])
    essential        = optional(bool, true)
    command          = optional(list(string), [])
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to the task definition resource."
  type        = map(string)
  default     = {}
}

variable "awslogs_region" {
  description = "Region used in logConfiguration. If empty, uses the current AWS provider region."
  type        = string
  default     = ""
}
