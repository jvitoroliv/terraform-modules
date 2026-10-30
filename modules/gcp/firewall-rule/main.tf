resource "google_compute_firewall" "this" {
  name    = var.name
  network = var.network
  project = var.project

  description = var.description
  direction   = var.direction
  priority    = var.priority

  source_ranges      = length(var.source_ranges) > 0 ? var.source_ranges : null
  destination_ranges = length(var.destination_ranges) > 0 ? var.destination_ranges : null

  # source_tags and source_service_accounts are mutually exclusive
  source_tags = length(var.source_service_accounts) == 0 && length(var.source_tags) > 0 ? var.source_tags : null
  target_tags = length(var.target_service_accounts) == 0 && length(var.target_tags) > 0 ? var.target_tags : null

  source_service_accounts = length(var.source_service_accounts) > 0 ? var.source_service_accounts : null
  target_service_accounts = length(var.target_service_accounts) > 0 ? var.target_service_accounts : null

  dynamic "allow" {
    for_each = var.allow_rules
    content {
      protocol = allow.value.protocol
      ports    = try(allow.value.ports, null)
    }
  }

  dynamic "deny" {
    for_each = var.deny_rules
    content {
      protocol = deny.value.protocol
      ports    = try(deny.value.ports, null)
    }
  }

  disabled = var.disabled
}
