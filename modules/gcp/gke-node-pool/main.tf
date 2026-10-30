resource "google_container_node_pool" "this" {
  name       = var.name
  location   = var.location
  cluster    = var.cluster
  project    = var.project
  node_count = var.node_count

  autoscaling {
    min_node_count = var.autoscaling.min_node_count
    max_node_count = var.autoscaling.max_node_count
  }

  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }

  node_config {
    preemptible  = var.node_config.preemptible
    spot         = var.node_config.spot
    machine_type = var.node_config.machine_type
    disk_size_gb = var.node_config.disk_size_gb
    disk_type    = var.node_config.disk_type

    service_account = var.node_config.service_account
    oauth_scopes    = var.node_config.oauth_scopes

    labels = var.node_config.labels
    tags   = var.node_config.tags

    dynamic "taint" {
      for_each = var.node_config.taints
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
    }

    dynamic "workload_metadata_config" {
      for_each = var.enable_workload_identity ? [1] : []
      content {
        mode = "GKE_METADATA"
      }
    }

    dynamic "gvnic" {
      for_each = var.node_config.enable_gvnic ? [1] : []
      content {
        enabled = true
      }
    }
  }
}
