variable "name" {
  description = "Name tag for the NAT Gateway."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the NAT Gateway will be deployed (must be a public subnet)."
  type        = string
}

variable "allocation_id" {
  description = "Elastic IP allocation ID to associate with the NAT Gateway."
  type        = string
}

variable "tags" {
  description = "Extra tags to apply."
  type        = map(string)
  default     = {}
}