locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_dns_managed_zone" "this" {
  name        = var.name
  dns_name    = var.dns_name
  description = var.description
  project     = var.project

  visibility = var.visibility

  dynamic "private_visibility_config" {
    for_each = var.private_visibility_config != null ? [var.private_visibility_config] : []
    content {
      dynamic "networks" {
        for_each = private_visibility_config.value.networks
        content {
          network_url = networks.value.network_url
        }
      }
    }
  }

  dynamic "dnssec_config" {
    for_each = var.dnssec_config != null ? [var.dnssec_config] : []
    content {
      state         = dnssec_config.value.state
      non_existence = try(dnssec_config.value.non_existence, null)
    }
  }

  labels = local.merged_labels
}
