output "name" {
  description = "Name of the database"
  value       = google_sql_database.this.name
}

output "id" {
  description = "ID of the database"
  value       = google_sql_database.this.id
}

output "self_link" {
  description = "Self link of the database"
  value       = google_sql_database.this.self_link
}
