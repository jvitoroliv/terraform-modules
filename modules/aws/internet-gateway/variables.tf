variable "name" {
  description = "Name tag for the Internet Gateway."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to attach the Internet Gateway."
  type        = string
}

variable "tags" {
  description = "Extra tags to apply."
  type        = map(string)
  default     = {}
}