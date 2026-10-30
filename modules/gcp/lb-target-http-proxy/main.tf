locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_compute_target_http_proxy" "this" {
  name        = var.name
  project     = var.project
  description = var.description
  url_map     = var.url_map

  proxy_bind = var.proxy_bind
}
