locals {
  merged_labels = merge({ name = var.repository_id }, var.labels)
}

resource "google_artifact_registry_repository" "this" {
  repository_id = var.repository_id
  location      = var.location
  format        = var.format
  project       = var.project
  description   = var.description

  dynamic "docker_config" {
    for_each = var.format == "DOCKER" && var.docker_immutable_tags ? [1] : []
    content {
      immutable_tags = true
    }
  }

  labels = local.merged_labels
}
