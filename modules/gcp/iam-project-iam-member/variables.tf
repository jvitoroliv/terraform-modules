variable "project" {
  description = "GCP project ID."
  type        = string
}

variable "role" {
  description = "IAM role to assign (e.g., roles/storage.objectViewer)."
  type        = string
}

variable "member" {
  description = "Member to grant the role to (e.g., serviceAccount:EMAIL, user:EMAIL)."
  type        = string
}
