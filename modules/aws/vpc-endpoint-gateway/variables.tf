# ======================================================================
# VPC ENDPOINT GATEWAY - INPUT VARIABLES
# ======================================================================

variable "vpc_id" {
  description = "VPC ID where the endpoint will be created"
  type        = string

  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "VPC ID must start with 'vpc-'."
  }
}

variable "service_name" {
  description = "AWS service name for the endpoint (e.g., com.amazonaws.us-east-1.s3)"
  type        = string

  validation {
    condition     = can(regex("^com\\.amazonaws\\.", var.service_name))
    error_message = "Service name must be a valid AWS service endpoint (com.amazonaws.{region}.{service})."
  }
}

variable "name" {
  description = "Name for the VPC endpoint (will be used in Name tag)"
  type        = string
}

variable "route_table_ids" {
  description = "List of route table IDs to associate with the endpoint (typically private subnet route tables)"
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.route_table_ids) > 0
    error_message = "At least one route table ID must be provided."
  }
}

variable "policy" {
  description = "IAM policy document for the VPC endpoint (JSON string). If null, allows full access to the service."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the VPC endpoint"
  type        = map(string)
  default     = {}
}
