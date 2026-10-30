variable "name" {
  description = "Name of the Cloud Run service."
  type        = string
}

variable "location" {
  description = "GCP region for the Cloud Run service."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the Cloud Run service."
  type        = string
  default     = ""
}

variable "container" {
  description = <<-EOT
    Container configuration:
    {
      name  = "app"
      image = "gcr.io/project/image:tag"
      port  = 8080
      env_vars = [
        { name = "ENV", value = "production" },
        { name = "SECRET", secret = { secret = "my-secret", version = "latest" } }
      ]
      resources = {
        cpu               = "1000m"
        memory            = "512Mi"
        cpu_idle          = true
        startup_cpu_boost = false
      }
    }
  EOT
  type = object({
    name  = string
    image = string
    port  = optional(number)
    env_vars = optional(list(object({
      name   = string
      value  = optional(string)
      secret = optional(object({
        secret  = string
        version = string
      }))
    })), [])
    resources = object({
      cpu               = string
      memory            = string
      cpu_idle          = optional(bool, true)
      startup_cpu_boost = optional(bool, false)
    })
  })
}

variable "min_instance_count" {
  description = "Minimum number of instances."
  type        = number
  default     = 0
}

variable "max_instance_count" {
  description = "Maximum number of instances."
  type        = number
  default     = 10
}

variable "max_instance_request_concurrency" {
  description = "Maximum concurrent requests per instance."
  type        = number
  default     = 80
}

variable "timeout" {
  description = "Maximum request timeout (e.g., '300s')."
  type        = string
  default     = "300s"
}

variable "service_account" {
  description = "Service account email for the Cloud Run service."
  type        = string
  default     = null
}

variable "vpc_access" {
  description = <<-EOT
    VPC Access Connector configuration:
    {
      connector = "projects/PROJECT/locations/REGION/connectors/CONNECTOR"
      egress    = "PRIVATE_RANGES_ONLY"
    }
  EOT
  type = object({
    connector = string
    egress    = optional(string)
  })
  default = null
}

variable "allow_unauthenticated" {
  description = "Allow unauthenticated access (allUsers invoker)."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to the Cloud Run service."
  type        = map(string)
  default     = {}
}

variable "use_http2" {
  description = "Use HTTP/2 for connections to the service. Required for responses larger than 32MB."
  type        = bool
  default     = false
}
