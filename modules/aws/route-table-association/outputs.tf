output "association_ids" {
  description = "List of association IDs created."
  value       = [for a in aws_route_table_association.this : a.id]
}