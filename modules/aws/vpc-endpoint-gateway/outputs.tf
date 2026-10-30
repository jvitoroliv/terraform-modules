# ======================================================================
# VPC ENDPOINT GATEWAY - OUTPUTS
# ======================================================================

output "vpc_endpoint_id" {
  description = "ID of the VPC endpoint"
  value       = aws_vpc_endpoint.this.id
}

output "vpc_endpoint_arn" {
  description = "ARN of the VPC endpoint"
  value       = aws_vpc_endpoint.this.arn
}

output "vpc_endpoint_state" {
  description = "State of the VPC endpoint (e.g., available, pending)"
  value       = aws_vpc_endpoint.this.state
}

output "vpc_endpoint_cidr_blocks" {
  description = "CIDR blocks for the VPC endpoint (for Gateway endpoints, this is the service prefix list)"
  value       = aws_vpc_endpoint.this.cidr_blocks
}

output "vpc_endpoint_prefix_list_id" {
  description = "Prefix list ID of the exposed AWS service (useful for security group rules)"
  value       = aws_vpc_endpoint.this.prefix_list_id
}

output "route_table_ids" {
  description = "Route table IDs associated with the endpoint"
  value       = var.route_table_ids
}
