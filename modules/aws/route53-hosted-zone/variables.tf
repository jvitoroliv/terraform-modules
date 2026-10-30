variable "name" {
  description = "Domain name for the hosted zone"
  type        = string
}

variable "comment" {
  description = "Comment for the hosted zone"
  type        = string
  default     = ""
}

variable "vpc_ids" {
  description = "List of VPC IDs to associate with private hosted zone"
  type        = list(string)
  default     = []
}

variable "vpc_region" {
  description = "Region for VPC association (required for private hosted zones)"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Allow destruction of hosted zone even if it contains records"
  type        = bool
  default     = false
}

variable "delegation_set_id" {
  description = "ID of delegation set to use for this hosted zone"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to assign to the hosted zone"
  type        = map(string)
  default     = {}
}