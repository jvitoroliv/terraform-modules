variable "repository_id" {
  description = "Repository ID (unique within location)."
  type        = string
}

variable "location" {
  description = "GCP region for the repository."
  type        = string
}

variable "format" {
  description = "Repository format: DOCKER, MAVEN, NPM, PYTHON, APT, YUM, etc."
  type        = string
  default     = "DOCKER"

  validation {
    condition     = contains(["DOCKER", "MAVEN", "NPM", "PYTHON", "APT", "YUM", "GO"], var.format)
    error_message = "format must be a valid Artifact Registry format."
  }
}

variable "project" {
  description = "GCP project ID."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the repository."
  type        = string
  default     = ""
}

variable "docker_immutable_tags" {
  description = "Enable immutable tags for Docker repositories."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to the repository."
  type        = map(string)
  default     = {}
}
