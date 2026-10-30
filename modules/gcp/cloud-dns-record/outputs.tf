output "name" {
  description = "Name of the DNS record"
  value       = google_dns_record_set.this.name
}

output "id" {
  description = "ID of the DNS record"
  value       = google_dns_record_set.this.id
}

output "type" {
  description = "Type of the DNS record"
  value       = google_dns_record_set.this.type
}
