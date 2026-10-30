locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_compute_target_https_proxy" "this" {
  name        = var.name
  project     = var.project
  description = var.description
  url_map     = var.url_map

  ssl_certificates = var.ssl_certificates
  certificate_map  = var.certificate_map
  proxy_bind       = var.proxy_bind
  quic_override    = var.quic_override
  ssl_policy       = var.ssl_policy

  http_keep_alive_timeout_sec = var.http_keep_alive_timeout_sec
}
