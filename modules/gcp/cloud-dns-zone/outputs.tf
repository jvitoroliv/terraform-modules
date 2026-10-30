output "name" {
  description = "Name of the DNS zone"
  value       = google_dns_managed_zone.this.name
}

output "id" {
  description = "ID of the DNS zone"
  value       = google_dns_managed_zone.this.id
}

output "dns_name" {
  description = "DNS name of the zone"
  value       = google_dns_managed_zone.this.dns_name
}

output "name_servers" {
  description = "List of name servers for the zone"
  value       = google_dns_managed_zone.this.name_servers
}
