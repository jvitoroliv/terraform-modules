resource "google_compute_router" "this" {
  name    = var.name
  network = var.network
  region  = var.region
  project = var.project

  description = var.description

  dynamic "bgp" {
    for_each = var.bgp_config != null ? [var.bgp_config] : []
    content {
      asn               = bgp.value.asn
      advertise_mode    = try(bgp.value.advertise_mode, "DEFAULT")
      advertised_groups = try(bgp.value.advertised_groups, null)
    }
  }
}
