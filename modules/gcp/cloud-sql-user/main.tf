resource "google_sql_user" "this" {
  name     = var.name
  instance = var.instance
  project  = var.project
  password = var.password
  host     = var.host
  type     = var.type

  deletion_policy = var.deletion_policy

  dynamic "password_policy" {
    for_each = var.password_policy != null ? [var.password_policy] : []
    content {
      allowed_failed_attempts      = try(password_policy.value.allowed_failed_attempts, null)
      password_expiration_duration = try(password_policy.value.password_expiration_duration, null)
      enable_failed_attempts_check = try(password_policy.value.enable_failed_attempts_check, false)
      enable_password_verification = try(password_policy.value.enable_password_verification, false)
    }
  }
}
