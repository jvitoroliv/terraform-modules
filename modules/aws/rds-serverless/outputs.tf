output "cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = aws_rds_cluster.this.id
}

output "cluster_arn" {
  description = "Amazon Resource Name (ARN) of the cluster"
  value       = aws_rds_cluster.this.arn
}

output "cluster_endpoint" {
  description = "The cluster endpoint"
  value       = aws_rds_cluster.this.endpoint
}

output "cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = aws_rds_cluster.this.reader_endpoint
}

output "cluster_database_name" {
  description = "The database name"
  value       = aws_rds_cluster.this.database_name
}

output "cluster_master_username" {
  description = "The master username for the database"
  value       = aws_rds_cluster.this.master_username
  sensitive   = true
}

output "cluster_port" {
  description = "The database port"
  value       = aws_rds_cluster.this.port
}

output "cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = aws_rds_cluster.this.hosted_zone_id
}

output "instance_endpoints" {
  description = "The connection endpoints for each RDS instance"
  value       = aws_rds_cluster_instance.this[*].endpoint
}

output "instance_ids" {
  description = "The instance identifiers"
  value       = aws_rds_cluster_instance.this[*].id
}

output "db_subnet_group_name" {
  description = "The db subnet group name"
  value       = aws_db_subnet_group.this.name
}

output "db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = aws_db_subnet_group.this.arn
}