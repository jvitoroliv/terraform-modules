variable "name" {
  description = "Name of the service discovery namespace"
  type        = string
}

variable "description" {
  description = "Description for the service discovery namespace"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID to associate with the private DNS namespace"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the namespace"
  type        = map(string)
  default     = {}
}