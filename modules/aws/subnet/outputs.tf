output "subnet_ids" {
  description = "List of subnet IDs in the same order as input."
  value       = [for s in aws_subnet.this : s.id]
}

output "subnet_arns" {
  description = "List of subnet ARNs in the same order as input."
  value       = [for s in aws_subnet.this : s.arn]
}

output "subnet_map" {
  description = "Map keyed by the provided 'name' with subnet IDs."
  value = {
    for s in aws_subnet.this :
    s.tags["Name"] => s.id
  }
}