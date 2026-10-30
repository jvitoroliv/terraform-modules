variable "name" {
  description = "The name of the launch template"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the launch template"
  type        = string
  default     = null
}

variable "image_id" {
  description = "The AMI ID to use for the launch template"
  type        = string
}

variable "instance_type" {
  description = "Instance type to use for the launch template"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "The Base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "iam_instance_profile_arn" {
  description = "The IAM Instance Profile ARN to launch the instance with"
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = []
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type = list(object({
    device_name = string
    ebs = optional(object({
      delete_on_termination = optional(bool, true)
      encrypted             = optional(bool, true)
      volume_size           = optional(number, 30)
      volume_type           = optional(string, "gp3")
      iops                  = optional(number)
      throughput            = optional(number)
    }))
  }))
  default = []
}

variable "network_interfaces" {
  description = "Customize network interfaces to be attached at instance boot time"
  type = list(object({
    associate_public_ip_address = optional(bool, false)
    delete_on_termination       = optional(bool, true)
    device_index                = optional(number, 0)
    security_groups             = optional(list(string), [])
  }))
  default = []
}

variable "enable_monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "metadata_options" {
  description = "The metadata options for the instance"
  type = object({
    http_endpoint               = optional(string, "enabled")
    http_tokens                 = optional(string, "required")
    http_put_response_hop_limit = optional(number, 1)
    instance_metadata_tags      = optional(string, "disabled")
  })
  default = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "disabled"
  }
}

variable "tags" {
  description = "A map of tags to add to the launch template and resources"
  type        = map(string)
  default     = {}
}