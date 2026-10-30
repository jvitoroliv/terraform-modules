variable "name" {
  description = "Name of the node pool."
  type        = string
}

variable "location" {
  description = "GCP region or zone for the node pool."
  type        = string
}

variable "cluster" {
  description = "GKE cluster name."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "node_count" {
  description = "Initial number of nodes per zone."
  type        = number
  default     = 1
}

variable "autoscaling" {
  description = "Autoscaling configuration."
  type = object({
    min_node_count = number
    max_node_count = number
  })
}

variable "auto_repair" {
  description = "Enable auto-repair."
  type        = bool
  default     = true
}

variable "auto_upgrade" {
  description = "Enable auto-upgrade."
  type        = bool
  default     = true
}

variable "node_config" {
  description = "Node configuration."
  type = object({
    preemptible     = optional(bool, false)
    spot            = optional(bool, false)
    machine_type    = string
    disk_size_gb    = optional(number, 100)
    disk_type       = optional(string, "pd-standard")
    service_account = optional(string)
    oauth_scopes    = optional(list(string), ["https://www.googleapis.com/auth/cloud-platform"])
    labels          = optional(map(string), {})
    tags            = optional(list(string), [])
    taints = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), [])
    enable_gvnic = optional(bool, false)
  })
}

variable "enable_workload_identity" {
  description = "Enable Workload Identity."
  type        = bool
  default     = true
}
