variable "name" {
  description = "Name of the database."
  type        = string
}

variable "instance" {
  description = "Cloud SQL instance name."
  type        = string
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "charset" {
  description = "Character set for the database."
  type        = string
  default     = "utf8"
}

variable "collation" {
  description = "Collation for the database."
  type        = string
  default     = "utf8_general_ci"
}

variable "deletion_policy" {
  description = "Deletion policy (DELETE or ABANDON)."
  type        = string
  default     = "DELETE"
  validation {
    condition     = contains(["DELETE", "ABANDON"], var.deletion_policy)
    error_message = "deletion_policy must be DELETE or ABANDON."
  }
}
