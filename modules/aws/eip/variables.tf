variable "name" {
  description = "Name tag for the Elastic IP."
  type        = string
}

variable "vpc" {
  description = "Set true if the EIP is for use in a VPC (default: true)."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Extra tags for the EIP."
  type        = map(string)
  default     = {}
}