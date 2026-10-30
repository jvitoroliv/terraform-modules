# ---- Region / naming ----
variable "region" {
  description = "AWS region where the backend (S3 + DynamoDB) will be created."
  type        = string
}

variable "project_name" {
  description = "Project identifier to tag and compose resource names."
  type        = string
  default     = "gameplatform"
}

variable "bucket_name" {
  description = <<-EOT
    Name of the S3 bucket that will store Terraform remote state.
    Must be globally unique. If empty, a name is composed from project and region.
  EOT
  type        = string
  default     = ""
}

variable "dynamodb_table_name" {
  description = <<-EOT
    Name of the DynamoDB table for state locking.
    If empty, a name is composed from project and region.
  EOT
  type        = string
  default     = ""
}

# ---- S3 controls ----
variable "force_destroy" {
  description = "If true, allows deleting the bucket even if it contains objects."
  type        = bool
  default     = false
}

variable "enable_bucket_versioning" {
  description = "Enable versioning on the state bucket."
  type        = bool
  default     = true
}

variable "enable_bucket_encryption" {
  description = "Enable server-side encryption (SSE-S3) on the bucket."
  type        = bool
  default     = true
}

variable "block_public_access" {
  description = "Create Public Access Block to fully deny public ACLs/policies."
  type        = bool
  default     = true
}

variable "bucket_lifecycle_days_abort_mpu" {
  description = "Lifecycle: abort incomplete multipart uploads after N days."
  type        = number
  default     = 7
}

# ---- DynamoDB controls ----
variable "dynamodb_point_in_time_recovery" {
  description = "Enable PITR on the DynamoDB lock table."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to be merged into default tags."
  type        = map(string)
  default     = {}
}