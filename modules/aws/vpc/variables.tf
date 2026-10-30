variable "name" {
  description = "Name tag for the VPC."
  type        = string
}

variable "cidr_block" {
  description = "Primary IPv4 CIDR block for the VPC."
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC (default or dedicated)."
  type        = string
  default     = "default"
  validation {
    condition     = contains(["default", "dedicated"], var.instance_tenancy)
    error_message = "Instance tenancy must be either 'default' or 'dedicated'."
  }
}

variable "tags" {
  description = "Extra tags to merge into the resource."
  type        = map(string)
  default     = {}
}
