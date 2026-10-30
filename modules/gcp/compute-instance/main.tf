locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_compute_instance" "this" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project

  description = var.description

  tags = var.tags

  boot_disk {
    auto_delete = var.boot_disk.auto_delete
    device_name = var.boot_disk.device_name
    mode        = var.boot_disk.mode

    initialize_params {
      image  = var.boot_disk.image
      size   = var.boot_disk.size
      type   = var.boot_disk.type
      labels = local.merged_labels
    }
  }

  dynamic "attached_disk" {
    for_each = var.attached_disks
    content {
      source      = attached_disk.value.source
      device_name = try(attached_disk.value.device_name, null)
      mode        = try(attached_disk.value.mode, "READ_WRITE")
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    dynamic "access_config" {
      for_each = var.assign_public_ip ? [1] : []
      content {
        nat_ip       = var.static_ip
        network_tier = var.network_tier
      }
    }

    dynamic "alias_ip_range" {
      for_each = var.alias_ip_ranges
      content {
        ip_cidr_range         = alias_ip_range.value.ip_cidr_range
        subnetwork_range_name = try(alias_ip_range.value.subnetwork_range_name, null)
      }
    }
  }

  metadata = merge(
    var.metadata,
    var.startup_script != null ? { startup-script = var.startup_script } : {}
  )

  dynamic "service_account" {
    for_each = var.service_account != null ? [var.service_account] : []
    content {
      email  = service_account.value.email
      scopes = service_account.value.scopes
    }
  }

  scheduling {
    preemptible                 = var.scheduling.preemptible
    automatic_restart           = var.scheduling.automatic_restart
    on_host_maintenance         = var.scheduling.on_host_maintenance
    provisioning_model          = var.scheduling.provisioning_model
    instance_termination_action = var.scheduling.instance_termination_action
  }

  shielded_instance_config {
    enable_secure_boot          = var.shielded_instance_config.enable_secure_boot
    enable_vtpm                 = var.shielded_instance_config.enable_vtpm
    enable_integrity_monitoring = var.shielded_instance_config.enable_integrity_monitoring
  }

  allow_stopping_for_update = var.allow_stopping_for_update
  deletion_protection       = var.deletion_protection
  can_ip_forward            = var.can_ip_forward

  labels = local.merged_labels

  lifecycle {
    ignore_changes = [
      metadata["ssh-keys"],
    ]
  }
}
