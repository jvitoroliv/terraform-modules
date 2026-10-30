variable "cluster_identifier" {
  description = "The cluster identifier"
  type        = string
}

variable "engine" {
  description = "The name of the database engine"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "database_name" {
  description = "The name of the database to create when the cluster is created"
  type        = string
  default     = null
}

variable "master_username" {
  description = "The username for the master DB user"
  type        = string
  default     = "postgres"
}

variable "master_password" {
  description = "The password for the master DB user"
  type        = string
  sensitive   = true
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = 5432
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the cluster"
  type        = list(string)
  default     = []
}

variable "serverless_min_capacity" {
  description = "The minimum capacity for Aurora Serverless v2 (in ACUs)"
  type        = number
  default     = 0.5
}

variable "serverless_max_capacity" {
  description = "The maximum capacity for Aurora Serverless v2 (in ACUs)"
  type        = number
  default     = 64
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = "03:00-04:00"
}

variable "preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
  type        = bool
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch"
  type        = list(string)
  default     = ["postgresql"]
}

variable "storage_encrypted" {
  description = "Specifies whether the DB cluster is encrypted"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The KMS key identifier for encryption"
  type        = string
  default     = null
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately"
  type        = bool
  default     = false
}

variable "allow_major_version_upgrade" {
  description = "Enable to allow major version upgrades"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "If the DB cluster should have deletion protection enabled"
  type        = bool
  default     = false
}

variable "enable_http_endpoint" {
  description = "Enable HTTP endpoint (data API)"
  type        = bool
  default     = false
}

variable "instance_count" {
  description = "Number of instances in the cluster"
  type        = number
  default     = 1
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "The KMS key identifier for Performance Insights data"
  type        = string
  default     = null
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch"
  type        = string
  default     = null
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected"
  type        = number
  default     = 0
}

variable "ca_cert_identifier" {
  description = "The identifier of the CA certificate for the DB instance"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}