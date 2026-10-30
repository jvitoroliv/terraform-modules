locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_compute_managed_ssl_certificate" "this" {
  name        = var.name
  project     = var.project
  description = var.description

  managed {
    domains = var.domains
  }

  lifecycle {
    create_before_destroy = true
  }
}
