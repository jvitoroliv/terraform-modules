resource "aws_rds_cluster" "this" {
  cluster_identifier     = var.cluster_identifier
  engine                 = var.engine
  engine_mode            = "provisioned"
  engine_version         = var.engine_version
  database_name          = var.database_name
  master_username        = var.master_username
  master_password        = var.master_password
  port                   = var.port
  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.this.name

  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.cluster_identifier}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  serverlessv2_scaling_configuration {
    max_capacity = var.serverless_max_capacity
    min_capacity = var.serverless_min_capacity
  }

  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_id

  apply_immediately            = var.apply_immediately
  allow_major_version_upgrade  = var.allow_major_version_upgrade
  deletion_protection          = var.deletion_protection
  enable_http_endpoint         = var.enable_http_endpoint

  tags = var.tags
}

resource "aws_rds_cluster_instance" "this" {
  count = var.instance_count

  identifier         = "${var.cluster_identifier}-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.this.engine
  engine_version     = aws_rds_cluster.this.engine_version

  performance_insights_enabled    = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_kms_key_id
  monitoring_role_arn             = var.monitoring_role_arn
  monitoring_interval             = var.monitoring_interval

  ca_cert_identifier = var.ca_cert_identifier

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_identifier}-${count.index + 1}"
    }
  )
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.cluster_identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_identifier}-subnet-group"
    }
  )
}