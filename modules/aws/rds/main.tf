locals {
  # Database configuration
  db_identifier = "${var.name_prefix}-${var.engine}"
  
  # Security and networking
  port = var.engine == "postgres" ? 5432 : var.port
  
  # Backup and maintenance
  backup_window      = var.backup_window
  maintenance_window = var.maintenance_window
  
  # Common tags
  common_tags = merge(var.tags, {
    Name        = local.db_identifier
    ManagedBy   = "terraform"
    Module      = "rds"
    Engine      = var.engine
    Environment = var.environment
  })
}

# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${local.db_identifier}-subnet-group"
  subnet_ids = var.subnet_ids
  
  tags = merge(local.common_tags, {
    Name = "${local.db_identifier}-subnet-group"
  })
}

# Security Group for RDS
resource "aws_security_group" "rds" {
  name_prefix = "${local.db_identifier}-"
  vpc_id      = var.vpc_id
  description = "Security group for ${local.db_identifier} RDS instance"

  ingress {
    from_port       = local.port
    to_port         = local.port
    protocol        = "tcp"
    security_groups = var.allowed_security_groups
    cidr_blocks     = var.allowed_cidr_blocks
    description     = "Database access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = merge(local.common_tags, {
    Name = "${local.db_identifier}-sg"
  })

  lifecycle {
    create_before_destroy = true
  }
}

# DB Parameter Group
resource "aws_db_parameter_group" "main" {
  count  = var.create_parameter_group ? 1 : 0
  family = var.parameter_group_family
  name   = "${local.db_identifier}-params"

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

# RDS Instance
resource "aws_db_instance" "main" {
  # Basic configuration
  identifier = local.db_identifier
  
  # Engine configuration
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  
  # Storage configuration
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted
  kms_key_id           = var.kms_key_id
  
  # Database configuration
  db_name  = var.database_name
  username = var.username
  password = var.password
  port     = local.port
  
  # Network configuration
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = var.publicly_accessible
  
  # Parameter group
  parameter_group_name = var.create_parameter_group ? aws_db_parameter_group.main[0].name : var.parameter_group_name
  
  # Backup configuration
  backup_retention_period = var.backup_retention_period
  backup_window          = local.backup_window
  copy_tags_to_snapshot  = true
  
  # Maintenance configuration
  maintenance_window         = local.maintenance_window
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  
  # Monitoring
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_arn
  
  # Performance Insights
  performance_insights_enabled = var.performance_insights_enabled
  
  # Deletion protection
  deletion_protection       = var.deletion_protection
  skip_final_snapshot      = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${local.db_identifier}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  
  tags = local.common_tags

  lifecycle {
    ignore_changes = [
      password,
      final_snapshot_identifier
    ]
  }
}