locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_container_cluster" "this" {
  name     = var.name
  location = var.location
  project  = var.project

  description = var.description

  # Datapath provider (ADVANCED_DATAPATH enables eBPF and native network policy)
  datapath_provider = var.datapath_provider

  # Minimum GKE version
  min_master_version = var.min_master_version

  # Release channel
  dynamic "release_channel" {
    for_each = var.release_channel != null ? [var.release_channel] : []
    content {
      channel = release_channel.value
    }
  }

  # Network configuration
  network    = var.network
  subnetwork = var.subnetwork

  # IP allocation policy (VPC-native cluster)
  dynamic "ip_allocation_policy" {
    for_each = var.ip_allocation_policy != null ? [var.ip_allocation_policy] : []
    content {
      cluster_secondary_range_name  = try(ip_allocation_policy.value.cluster_secondary_range_name, null)
      services_secondary_range_name = try(ip_allocation_policy.value.services_secondary_range_name, null)
    }
  }

  # Private cluster configuration
  dynamic "private_cluster_config" {
    for_each = var.private_cluster_config != null ? [var.private_cluster_config] : []
    content {
      enable_private_nodes    = private_cluster_config.value.enable_private_nodes
      enable_private_endpoint = private_cluster_config.value.enable_private_endpoint
      master_ipv4_cidr_block  = try(private_cluster_config.value.master_ipv4_cidr_block, null)

      dynamic "master_global_access_config" {
        for_each = try(private_cluster_config.value.master_global_access, false) ? [1] : []
        content {
          enabled = true
        }
      }
    }
  }

  # Master authorized networks
  dynamic "master_authorized_networks_config" {
    for_each = var.master_authorized_networks != null ? [var.master_authorized_networks] : []
    content {
      dynamic "cidr_blocks" {
        for_each = master_authorized_networks_config.value
        content {
          cidr_block   = cidr_blocks.value.cidr_block
          display_name = try(cidr_blocks.value.display_name, null)
        }
      }
    }
  }

  # Workload Identity
  dynamic "workload_identity_config" {
    for_each = var.enable_workload_identity ? [1] : []
    content {
      workload_pool = "${var.project != null ? var.project : data.google_project.current[0].project_id}.svc.id.goog"
    }
  }

  # Maintenance policy
  dynamic "maintenance_policy" {
    for_each = var.maintenance_window != null ? [var.maintenance_window] : []
    content {
      daily_maintenance_window {
        start_time = maintenance_policy.value.start_time
      }
    }
  }

  # Monitoring and logging
  monitoring_config {
    enable_components = var.monitoring_components

    dynamic "managed_prometheus" {
      for_each = var.enable_managed_prometheus ? [1] : []
      content {
        enabled = true
      }
    }
  }

  logging_config {
    enable_components = var.logging_components
  }

  # Addons configuration
  dynamic "addons_config" {
    for_each = var.addons_config != null ? [var.addons_config] : []
    content {
      dynamic "http_load_balancing" {
        for_each = try(addons_config.value.http_load_balancing, null) != null ? [addons_config.value.http_load_balancing] : []
        content {
          disabled = !http_load_balancing.value
        }
      }

      dynamic "horizontal_pod_autoscaling" {
        for_each = try(addons_config.value.horizontal_pod_autoscaling, null) != null ? [addons_config.value.horizontal_pod_autoscaling] : []
        content {
          disabled = !horizontal_pod_autoscaling.value
        }
      }

      dynamic "network_policy_config" {
        for_each = try(addons_config.value.network_policy, null) != null ? [addons_config.value.network_policy] : []
        content {
          disabled = !network_policy_config.value
        }
      }

      dynamic "gce_persistent_disk_csi_driver_config" {
        for_each = try(addons_config.value.gce_persistent_disk_csi_driver, null) != null ? [addons_config.value.gce_persistent_disk_csi_driver] : []
        content {
          enabled = gce_persistent_disk_csi_driver_config.value
        }
      }
    }
  }

  # Remove default node pool (Standard mode)
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count

  # Prevent destruction
  deletion_protection = var.deletion_protection

  # Gateway API configuration
  dynamic "gateway_api_config" {
    for_each = var.gateway_api_channel != null ? [var.gateway_api_channel] : []
    content {
      channel = gateway_api_config.value
    }
  }

  resource_labels = local.merged_labels
}

# Data source for current project (if project not specified)
data "google_project" "current" {
  count = var.project == null ? 1 : 0
}
