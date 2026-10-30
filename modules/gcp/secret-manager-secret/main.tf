locals {
  merged_labels = merge({ name = var.secret_id }, var.labels)
}

resource "google_secret_manager_secret" "this" {
  secret_id = var.secret_id
  project   = var.project

  labels = local.merged_labels

  replication {
    dynamic "auto" {
      for_each = var.replication_policy == "auto" ? [1] : []
      content {
        dynamic "customer_managed_encryption" {
          for_each = var.kms_key_name != null ? [1] : []
          content {
            kms_key_name = var.kms_key_name
          }
        }
      }
    }

    dynamic "user_managed" {
      for_each = var.replication_policy == "user_managed" ? [1] : []
      content {
        dynamic "replicas" {
          for_each = var.replicas
          content {
            location = replicas.value.location

            dynamic "customer_managed_encryption" {
              for_each = try(replicas.value.kms_key_name, null) != null ? [1] : []
              content {
                kms_key_name = replicas.value.kms_key_name
              }
            }
          }
        }
      }
    }
  }

  dynamic "topics" {
    for_each = var.topics
    content {
      name = topics.value
    }
  }

  dynamic "rotation" {
    for_each = var.rotation != null ? [var.rotation] : []
    content {
      next_rotation_time = try(rotation.value.next_rotation_time, null)
      rotation_period    = try(rotation.value.rotation_period, null)
    }
  }

  expire_time = var.expire_time
  ttl         = var.ttl

  annotations = var.annotations

  version_aliases = var.version_aliases

}
