variable "name" {
  description = "CloudWatch Log Group name (e.g., /gameplatform/pr-123/server)."
  type        = string
}

variable "retention_in_days" {
  description = "Retention in days. Use 0 for never expire."
  type        = number
  default     = 7
}

variable "kms_key_id" {
  description = "Optional KMS key ARN/ID for log encryption. If empty, AWS-managed encryption is used."
  type        = string
  default     = ""
}

variable "log_group_class" {
  description = "STANDARD or INFREQUENT_ACCESS (cheaper for rarely-read logs)."
  type        = string
  default     = "STANDARD"
  validation {
    condition     = contains(["STANDARD", "INFREQUENT_ACCESS"], var.log_group_class)
    error_message = "Log group class must be STANDARD or INFREQUENT_ACCESS."
  }
}

variable "tags" {
  description = "Extra tags for the log group."
  type        = map(string)
  default     = {}
}
