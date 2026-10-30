# RDS Instance outputs
output "id" {
  description = "RDS instance ID"
  value       = aws_db_instance.main.id
}

output "arn" {
  description = "RDS instance ARN"
  value       = aws_db_instance.main.arn
}

output "endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.main.endpoint
}

output "address" {
  description = "RDS instance address"
  value       = aws_db_instance.main.address
}

output "port" {
  description = "RDS instance port"
  value       = aws_db_instance.main.port
}

output "database_name" {
  description = "Database name"
  value       = aws_db_instance.main.db_name
}

output "username" {
  description = "Database master username"
  value       = aws_db_instance.main.username
  sensitive   = true
}

# Connection information
output "connection_string" {
  description = "Database connection string (without password)"
  value       = "postgresql://${aws_db_instance.main.username}:PASSWORD@${aws_db_instance.main.endpoint}/${aws_db_instance.main.db_name}"
  sensitive   = true
}

output "jdbc_connection_string" {
  description = "JDBC connection string"
  value       = "jdbc:postgresql://${aws_db_instance.main.endpoint}/${aws_db_instance.main.db_name}"
}

# Security
output "security_group_id" {
  description = "Security group ID for RDS instance"
  value       = aws_security_group.rds.id
}

# Subnet group
output "subnet_group_name" {
  description = "DB subnet group name"
  value       = aws_db_subnet_group.main.name
}

output "subnet_group_arn" {
  description = "DB subnet group ARN"
  value       = aws_db_subnet_group.main.arn
}

# Parameter group
output "parameter_group_name" {
  description = "DB parameter group name"
  value       = var.create_parameter_group ? aws_db_parameter_group.main[0].name : var.parameter_group_name
}

# Status
output "status" {
  description = "RDS instance status"
  value       = aws_db_instance.main.status
}

output "availability_zone" {
  description = "RDS instance availability zone"
  value       = aws_db_instance.main.availability_zone
}

# Backup
output "backup_window" {
  description = "RDS backup window"
  value       = aws_db_instance.main.backup_window
}

output "maintenance_window" {
  description = "RDS maintenance window"
  value       = aws_db_instance.main.maintenance_window
}