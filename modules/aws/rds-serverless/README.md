# AWS RDS Aurora Serverless v2 Module

This module creates an AWS RDS Aurora Serverless v2 cluster with PostgreSQL or MySQL.

## Usage

```hcl
module "rds_serverless" {
  source = "../../modules/aws/rds-serverless"

  cluster_identifier = "my-serverless-cluster"
  engine             = "aurora-postgresql"
  engine_version     = "16.6"
  database_name      = "mydb"
  master_username    = "postgres"
  master_password    = var.db_password

  subnet_ids         = ["subnet-123", "subnet-456"]
  security_group_ids = ["sg-123456"]

  serverless_min_capacity = 0.5
  serverless_max_capacity = 64

  instance_count = 1

  tags = {
    Environment = "Production"
    Application = "MyApp"
  }
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| cluster_identifier | The cluster identifier | string | - |
| engine | The name of the database engine | string | "aurora-postgresql" |
| engine_version | The engine version to use | string | - |
| database_name | The name of the database to create when the cluster is created | string | null |
| master_username | The username for the master DB user | string | "postgres" |
| master_password | The password for the master DB user | string | - |
| port | The port on which the DB accepts connections | number | 5432 |
| subnet_ids | List of subnet IDs for the DB subnet group | list(string) | - |
| security_group_ids | List of security group IDs to associate with the cluster | list(string) | [] |
| serverless_min_capacity | The minimum capacity for Aurora Serverless v2 (in ACUs) | number | 0.5 |
| serverless_max_capacity | The maximum capacity for Aurora Serverless v2 (in ACUs) | number | 64 |
| backup_retention_period | The days to retain backups for | number | 7 |
| preferred_backup_window | The daily time range during which automated backups are created | string | "03:00-04:00" |
| preferred_maintenance_window | The weekly time range during which system maintenance can occur | string | "sun:04:00-sun:05:00" |
| skip_final_snapshot | Determines whether a final DB snapshot is created before the DB cluster is deleted | bool | false |
| enabled_cloudwatch_logs_exports | List of log types to export to CloudWatch | list(string) | ["postgresql"] |
| storage_encrypted | Specifies whether the DB cluster is encrypted | bool | true |
| kms_key_id | The KMS key identifier for encryption | string | null |
| apply_immediately | Specifies whether any cluster modifications are applied immediately | bool | false |
| allow_major_version_upgrade | Enable to allow major version upgrades | bool | false |
| deletion_protection | If the DB cluster should have deletion protection enabled | bool | false |
| enable_http_endpoint | Enable HTTP endpoint (data API) | bool | false |
| instance_count | Number of instances in the cluster | number | 1 |
| performance_insights_enabled | Specifies whether Performance Insights are enabled | bool | false |
| performance_insights_kms_key_id | The KMS key identifier for Performance Insights data | string | null |
| monitoring_role_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch | string | null |
| monitoring_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected | number | 0 |
| ca_cert_identifier | The identifier of the CA certificate for the DB instance | string | null |
| tags | A map of tags to add to all resources | map(string) | {} |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The RDS Cluster Identifier |
| cluster_arn | Amazon Resource Name (ARN) of the cluster |
| cluster_endpoint | The cluster endpoint |
| cluster_reader_endpoint | The cluster reader endpoint |
| cluster_database_name | The database name |
| cluster_master_username | The master username for the database |
| cluster_port | The database port |
| cluster_hosted_zone_id | The Route53 Hosted Zone ID of the endpoint |
| instance_endpoints | The connection endpoints for each RDS instance |
| instance_ids | The instance identifiers |
| db_subnet_group_name | The db subnet group name |
| db_subnet_group_arn | The ARN of the db subnet group |