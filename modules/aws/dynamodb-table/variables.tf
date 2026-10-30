variable "name" {
  description = "DynamoDB table name."
  type        = string
}

variable "billing_mode" {
  description = "PAY_PER_REQUEST or PROVISIONED."
  type        = string
  default     = "PAY_PER_REQUEST"
  validation {
    condition     = contains(["PAY_PER_REQUEST", "PROVISIONED"], var.billing_mode)
    error_message = "Billing mode must be PAY_PER_REQUEST or PROVISIONED."
  }
}

variable "read_capacity" {
  description = "Read capacity units (only when billing_mode = PROVISIONED)."
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "Write capacity units (only when billing_mode = PROVISIONED)."
  type        = number
  default     = 5
}

variable "hash_key" {
  description = "Partition key name."
  type        = string
}

variable "range_key" {
  description = "Sort key name (optional)."
  type        = string
  default     = ""
}

variable "attributes" {
  description = <<-EOT
    Attribute definitions. Example:
    [
      { name = "PK", type = "S" },
      { name = "SK", type = "S" }
    ]
  EOT
  type = list(object({
    name = string
    type = string # S | N | B
  }))
}

variable "global_secondary_indexes" {
  description = <<-EOT
    Optional GSIs. Example:
    [
      {
        name               = "GSI1"
        hash_key           = "GSI1PK"
        range_key          = "GSI1SK"     # optional
        projection_type    = "KEYS_ONLY"  # or INCLUDE, ALL
        non_key_attributes = []           # when projection_type = INCLUDE
        read_capacity      = 5            # only for PROVISIONED
        write_capacity     = 5            # only for PROVISIONED
      }
    ]
  EOT
  type = list(object({
    name               = string
    hash_key           = string
    range_key          = optional(string)
    projection_type    = string
    non_key_attributes = optional(list(string), [])
    read_capacity      = optional(number)
    write_capacity     = optional(number)
  }))
  default = []
}

variable "ttl" {
  description = <<-EOT
    TTL configuration. Example:
    {
      attribute_name = "expiresAt"  # epoch seconds
      enabled        = true
    }
  EOT
  type = object({
    attribute_name = string
    enabled        = bool
  })
  default = null
}

variable "stream_enabled" {
  description = "Enable DynamoDB streams."
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "Stream view type: KEYS_ONLY | NEW_IMAGE | OLD_IMAGE | NEW_AND_OLD_IMAGES."
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
  validation {
    condition     = contains(["KEYS_ONLY", "NEW_IMAGE", "OLD_IMAGE", "NEW_AND_OLD_IMAGES"], var.stream_view_type)
    error_message = "Invalid stream_view_type."
  }
}

variable "point_in_time_recovery" {
  description = "Enable point-in-time recovery (PITR)."
  type        = bool
  default     = true
}

variable "server_side_encryption" {
  description = "Enable server-side encryption."
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "Custom KMS CMK ARN for SSE. If empty, AWS-owned key is used."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags applied to the table."
  type        = map(string)
  default     = {}
}
