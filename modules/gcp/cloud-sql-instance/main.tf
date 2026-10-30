locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_sql_database_instance" "this" {
  name             = var.name
  database_version = var.database_version
  region           = var.region
  project          = var.project

  deletion_protection = var.deletion_protection

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_type         = var.disk_type
    disk_size         = var.disk_size
    disk_autoresize   = var.disk_autoresize

    dynamic "ip_configuration" {
      for_each = [var.ip_configuration]
      content {
        ipv4_enabled    = ip_configuration.value.ipv4_enabled
        private_network = try(ip_configuration.value.private_network, null)
        require_ssl     = try(ip_configuration.value.require_ssl, false)

        dynamic "authorized_networks" {
          for_each = try(ip_configuration.value.authorized_networks, [])
          content {
            name  = authorized_networks.value.name
            value = authorized_networks.value.value
          }
        }
      }
    }

    dynamic "backup_configuration" {
      for_each = var.backup_configuration != null ? [var.backup_configuration] : []
      content {
        enabled                        = backup_configuration.value.enabled
        start_time                     = try(backup_configuration.value.start_time, "03:00")
        point_in_time_recovery_enabled = try(backup_configuration.value.point_in_time_recovery_enabled, false)
        transaction_log_retention_days = try(backup_configuration.value.transaction_log_retention_days, 7)

        dynamic "backup_retention_settings" {
          for_each = try(backup_configuration.value.retained_backups, null) != null ? [1] : []
          content {
            retained_backups = backup_configuration.value.retained_backups
          }
        }
      }
    }

    dynamic "maintenance_window" {
      for_each = var.maintenance_window != null ? [var.maintenance_window] : []
      content {
        day  = maintenance_window.value.day
        hour = maintenance_window.value.hour
      }
    }

    user_labels = local.merged_labels
  }
}
