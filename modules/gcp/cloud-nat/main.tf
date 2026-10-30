resource "google_compute_router_nat" "this" {
  name    = var.name
  router  = var.router
  region  = var.region
  project = var.project

  nat_ip_allocate_option             = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat

  min_ports_per_vm                   = var.min_ports_per_vm
  max_ports_per_vm                   = var.max_ports_per_vm
  enable_dynamic_port_allocation     = var.enable_dynamic_port_allocation
  enable_endpoint_independent_mapping = var.enable_endpoint_independent_mapping

  dynamic "log_config" {
    for_each = var.log_config != null ? [var.log_config] : []
    content {
      enable = log_config.value.enable
      filter = log_config.value.filter
    }
  }

  dynamic "subnetwork" {
    for_each = var.subnetworks
    content {
      name                    = subnetwork.value.name
      source_ip_ranges_to_nat = subnetwork.value.source_ip_ranges_to_nat
    }
  }
}
