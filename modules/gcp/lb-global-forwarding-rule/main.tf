locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_compute_global_forwarding_rule" "this" {
  name        = var.name
  project     = var.project
  description = var.description

  target                = var.target
  port_range            = var.port_range
  ip_protocol           = var.ip_protocol
  ip_address            = var.ip_address
  load_balancing_scheme = var.load_balancing_scheme

  labels = local.merged_labels

  dynamic "metadata_filters" {
    for_each = var.metadata_filters
    content {
      filter_match_criteria = metadata_filters.value.filter_match_criteria

      dynamic "filter_labels" {
        for_each = metadata_filters.value.filter_labels
        content {
          name  = filter_labels.value.name
          value = filter_labels.value.value
        }
      }
    }
  }
}
