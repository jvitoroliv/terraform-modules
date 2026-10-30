variable "name" {
  description = "Name of the compute instance."
  type        = string
}

variable "machine_type" {
  description = "Machine type (e.g., e2-medium, n2-standard-2)."
  type        = string
}

variable "zone" {
  description = "Zone where the instance will be created."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the instance."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Network tags for firewall rules."
  type        = list(string)
  default     = []
}

variable "boot_disk" {
  description = <<-EOT
    Boot disk configuration:
    {
      image       = "debian-cloud/debian-11"
      size        = 50
      type        = "pd-balanced"
      auto_delete = true
      device_name = "boot"
      mode        = "READ_WRITE"
    }
  EOT
  type = object({
    image       = string
    size        = optional(number, 50)
    type        = optional(string, "pd-balanced")
    auto_delete = optional(bool, true)
    device_name = optional(string, null)
    mode        = optional(string, "READ_WRITE")
  })
}

variable "attached_disks" {
  description = "List of additional disks to attach."
  type = list(object({
    source      = string
    device_name = optional(string)
    mode        = optional(string)
  }))
  default = []
}

variable "network" {
  description = "VPC network self_link or name."
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork self_link or name."
  type        = string
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP address."
  type        = bool
  default     = false
}

variable "static_ip" {
  description = "Static external IP address (requires assign_public_ip = true)."
  type        = string
  default     = null
}

variable "network_tier" {
  description = "Network tier for external IP (PREMIUM or STANDARD)."
  type        = string
  default     = "PREMIUM"
}

variable "alias_ip_ranges" {
  description = "Alias IP ranges for the network interface."
  type = list(object({
    ip_cidr_range         = string
    subnetwork_range_name = optional(string)
  }))
  default = []
}

variable "metadata" {
  description = "Metadata key/value pairs."
  type        = map(string)
  default     = {}
}

variable "startup_script" {
  description = "Startup script content."
  type        = string
  default     = null
}

variable "service_account" {
  description = <<-EOT
    Service account configuration:
    {
      email  = "sa@project.iam.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }
  EOT
  type = object({
    email  = string
    scopes = list(string)
  })
  default = null
}

variable "scheduling" {
  description = "Scheduling configuration."
  type = object({
    preemptible                 = optional(bool, false)
    automatic_restart           = optional(bool, true)
    on_host_maintenance         = optional(string, "MIGRATE")
    provisioning_model          = optional(string, "STANDARD")
    instance_termination_action = optional(string, null)
  })
  default = {}
}

variable "shielded_instance_config" {
  description = "Shielded instance configuration."
  type = object({
    enable_secure_boot          = optional(bool, false)
    enable_vtpm                 = optional(bool, true)
    enable_integrity_monitoring = optional(bool, true)
  })
  default = {}
}

variable "allow_stopping_for_update" {
  description = "Allow stopping the instance for updates."
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Enable deletion protection."
  type        = bool
  default     = false
}

variable "can_ip_forward" {
  description = "Allow IP forwarding."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to the instance."
  type        = map(string)
  default     = {}
}
