resource "google_sql_database" "this" {
  name      = var.name
  instance  = var.instance
  project   = var.project
  charset   = var.charset
  collation = var.collation

  deletion_policy = var.deletion_policy
}

