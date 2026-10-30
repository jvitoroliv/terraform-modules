resource "google_service_account_key" "this" {
  service_account_id = var.service_account_id
  key_algorithm      = var.key_algorithm
  private_key_type   = var.private_key_type
  public_key_type    = var.public_key_type

  dynamic "keepers" {
    for_each = var.keepers != null ? [var.keepers] : []
    content {
      rotation_time = try(keepers.value.rotation_time, null)
    }
  }
}
