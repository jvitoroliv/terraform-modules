resource "google_dns_record_set" "this" {
  name         = var.name
  type         = var.type
  ttl          = var.ttl
  managed_zone = var.managed_zone
  project      = var.project

  rrdatas = var.rrdatas
}
