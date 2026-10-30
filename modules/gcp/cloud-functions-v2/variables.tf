variable "name" {
  description = "Name of the Cloud Function."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "location" {
  description = "Region for the Cloud Function."
  type        = string
}

variable "description" {
  description = "Description of the Cloud Function."
  type        = string
  default     = ""
}

variable "runtime" {
  description = "Runtime environment (e.g., python311, nodejs20, go121)."
  type        = string
}

variable "entry_point" {
  description = "Entry point function name."
  type        = string
}

variable "source_bucket" {
  description = "Cloud Storage bucket containing source code."
  type        = string
}

variable "source_object" {
  description = "Cloud Storage object name (zip file)."
  type        = string
}

variable "build_environment_variables" {
  description = "Environment variables for build process."
  type        = map(string)
  default     = {}
}

variable "docker_repository" {
  description = "Docker repository for the function image."
  type        = string
  default     = null
}

variable "worker_pool" {
  description = "Cloud Build worker pool for building the function."
  type        = string
  default     = null
}

variable "max_instance_count" {
  description = "Maximum number of instances."
  type        = number
  default     = 100
}

variable "min_instance_count" {
  description = "Minimum number of instances."
  type        = number
  default     = 0
}

variable "available_memory" {
  description = "Memory available for function (e.g., 256M, 512M, 1Gi, 2Gi)."
  type        = string
  default     = "256M"
}

variable "available_cpu" {
  description = "CPU available for function (e.g., 1, 2)."
  type        = string
  default     = "1"
}

variable "timeout_seconds" {
  description = "Function timeout in seconds."
  type        = number
  default     = 60
}

variable "max_instance_request_concurrency" {
  description = "Maximum concurrent requests per instance."
  type        = number
  default     = 1
}

variable "environment_variables" {
  description = "Runtime environment variables."
  type        = map(string)
  default     = {}
}

variable "ingress_settings" {
  description = "Ingress settings (ALLOW_ALL, ALLOW_INTERNAL_ONLY, ALLOW_INTERNAL_AND_GCLB)."
  type        = string
  default     = "ALLOW_ALL"
}

variable "all_traffic_on_latest_revision" {
  description = "Route all traffic to latest revision."
  type        = bool
  default     = true
}

variable "service_account_email" {
  description = "Service account email for the function."
  type        = string
  default     = null
}

variable "vpc_connector" {
  description = "VPC Access Connector name."
  type        = string
  default     = null
}

variable "vpc_connector_egress_settings" {
  description = "VPC egress settings (ALL_TRAFFIC, PRIVATE_RANGES_ONLY)."
  type        = string
  default     = "PRIVATE_RANGES_ONLY"
}

variable "secret_environment_variables" {
  description = "List of secret environment variables."
  type = list(object({
    key        = string
    project_id = optional(string)
    secret     = string
    version    = string
  }))
  default = []
}

variable "secret_volumes" {
  description = "List of secret volumes."
  type = list(object({
    mount_path = string
    project_id = optional(string)
    secret     = string
    versions = list(object({
      version = string
      path    = string
    }))
  }))
  default = []
}

variable "event_trigger" {
  description = "Event trigger configuration for Eventarc."
  type = object({
    trigger_region        = optional(string)
    event_type            = string
    pubsub_topic          = optional(string)
    service_account_email = optional(string)
    retry_policy          = optional(string, "RETRY_POLICY_RETRY")
    event_filters = optional(list(object({
      attribute = string
      value     = string
      operator  = optional(string)
    })), [])
  })
  default = null
}

variable "labels" {
  description = "Labels to apply to the Cloud Function."
  type        = map(string)
  default     = {}
}

