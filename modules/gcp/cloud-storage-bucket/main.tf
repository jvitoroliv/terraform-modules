locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_storage_bucket" "this" {
  name          = var.name
  location      = var.location
  project       = var.project
  storage_class = var.storage_class
  force_destroy = var.force_destroy

  uniform_bucket_level_access = var.uniform_bucket_level_access

  dynamic "versioning" {
    for_each = var.versioning_enabled ? [1] : []
    content {
      enabled = true
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = try(lifecycle_rule.value.action.storage_class, null)
      }
      condition {
        age                   = try(lifecycle_rule.value.condition.age, null)
        created_before        = try(lifecycle_rule.value.condition.created_before, null)
        num_newer_versions    = try(lifecycle_rule.value.condition.num_newer_versions, null)
        matches_storage_class = try(lifecycle_rule.value.condition.matches_storage_class, null)
      }
    }
  }

  dynamic "encryption" {
    for_each = var.encryption_key != null ? [var.encryption_key] : []
    content {
      default_kms_key_name = encryption.value
    }
  }

  dynamic "cors" {
    for_each = var.cors_config != null ? [var.cors_config] : []
    content {
      origin          = cors.value.origin
      method          = cors.value.method
      response_header = try(cors.value.response_header, [])
      max_age_seconds = try(cors.value.max_age_seconds, 3600)
    }
  }

  labels = local.merged_labels
}
