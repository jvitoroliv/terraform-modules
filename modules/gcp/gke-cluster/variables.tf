variable "name" {
  description = "Name of the GKE cluster."
  type        = string
}

variable "location" {
  description = "GCP region or zone for the cluster."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the GKE cluster."
  type        = string
  default     = ""
}

variable "enable_autopilot" {
  description = "Enable Autopilot mode (fully managed cluster)."
  type        = bool
  default     = false
}

variable "min_master_version" {
  description = "Minimum GKE master version."
  type        = string
  default     = null
}

variable "release_channel" {
  description = "Release channel: RAPID, REGULAR, STABLE, or UNSPECIFIED."
  type        = string
  default     = "REGULAR"

  validation {
    condition     = contains(["RAPID", "REGULAR", "STABLE", "UNSPECIFIED"], var.release_channel)
    error_message = "release_channel must be RAPID, REGULAR, STABLE, or UNSPECIFIED."
  }
}

variable "network" {
  description = "VPC network self link."
  type        = string
}

variable "subnetwork" {
  description = "VPC subnetwork self link."
  type        = string
}

variable "ip_allocation_policy" {
  description = <<-EOT
    IP allocation policy for VPC-native cluster:
    {
      cluster_secondary_range_name  = "pods"
      services_secondary_range_name = "services"
    }
  EOT
  type = object({
    cluster_secondary_range_name  = optional(string)
    services_secondary_range_name = optional(string)
  })
  default = null
}

variable "private_cluster_config" {
  description = <<-EOT
    Private cluster configuration:
    {
      enable_private_nodes    = true
      enable_private_endpoint = false
      master_ipv4_cidr_block  = "172.16.0.0/28"
      master_global_access    = true
    }
  EOT
  type = object({
    enable_private_nodes    = bool
    enable_private_endpoint = bool
    master_ipv4_cidr_block  = optional(string)
    master_global_access    = optional(bool)
  })
  default = null
}

variable "master_authorized_networks" {
  description = <<-EOT
    Master authorized networks (whitelist CIDRs):
    [
      {
        cidr_block   = "10.0.0.0/8"
        display_name = "internal"
      }
    ]
  EOT
  type = list(object({
    cidr_block   = string
    display_name = optional(string)
  }))
  default = null
}

variable "enable_workload_identity" {
  description = "Enable Workload Identity for GKE."
  type        = bool
  default     = true
}

variable "maintenance_window" {
  description = <<-EOT
    Daily maintenance window:
    {
      start_time = "03:00"
    }
  EOT
  type = object({
    start_time = string
  })
  default = null
}

variable "monitoring_components" {
  description = "Monitoring components to enable: SYSTEM_COMPONENTS, WORKLOADS, etc."
  type        = list(string)
  default     = ["SYSTEM_COMPONENTS"]
}

variable "enable_managed_prometheus" {
  description = "Enable Google Cloud Managed Service for Prometheus."
  type        = bool
  default     = false
}

variable "logging_components" {
  description = "Logging components to enable: SYSTEM_COMPONENTS, WORKLOADS, etc."
  type        = list(string)
  default     = ["SYSTEM_COMPONENTS", "WORKLOADS"]
}

variable "addons_config" {
  description = <<-EOT
    Addons configuration:
    {
      http_load_balancing              = true
      horizontal_pod_autoscaling       = true
      network_policy                   = false
      gce_persistent_disk_csi_driver   = true
    }
  EOT
  type = object({
    http_load_balancing            = optional(bool)
    horizontal_pod_autoscaling     = optional(bool)
    network_policy                 = optional(bool)
    gce_persistent_disk_csi_driver = optional(bool)
  })
  default = null
}

variable "remove_default_node_pool" {
  description = "Remove default node pool after cluster creation (Standard mode only)."
  type        = bool
  default     = true
}

variable "initial_node_count" {
  description = "Initial node count for default node pool (Standard mode only)."
  type        = number
  default     = 1
}

variable "deletion_protection" {
  description = "Enable deletion protection for the cluster."
  type        = bool
  default     = true
}

variable "datapath_provider" {
  description = "Datapath provider: LEGACY_DATAPATH or ADVANCED_DATAPATH (eBPF-based, includes native network policy)."
  type        = string
  default     = null

  validation {
    condition     = var.datapath_provider == null || contains(["DATAPATH_PROVIDER_UNSPECIFIED", "LEGACY_DATAPATH", "ADVANCED_DATAPATH"], var.datapath_provider)
    error_message = "datapath_provider must be DATAPATH_PROVIDER_UNSPECIFIED, LEGACY_DATAPATH, or ADVANCED_DATAPATH."
  }
}

variable "gateway_api_channel" {
  description = "Gateway API channel: CHANNEL_DISABLED, CHANNEL_EXPERIMENTAL, or CHANNEL_STANDARD."
  type        = string
  default     = null

  validation {
    condition     = var.gateway_api_channel == null || contains(["CHANNEL_DISABLED", "CHANNEL_EXPERIMENTAL", "CHANNEL_STANDARD"], var.gateway_api_channel)
    error_message = "gateway_api_channel must be CHANNEL_DISABLED, CHANNEL_EXPERIMENTAL, or CHANNEL_STANDARD."
  }
}

variable "labels" {
  description = "Labels to apply to the GKE cluster."
  type        = map(string)
  default     = {}
}
