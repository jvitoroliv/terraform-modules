# ======================================================================
# VPC ENDPOINT GATEWAY MODULE
# ======================================================================
# Creates a VPC Endpoint Gateway for AWS services (S3, DynamoDB)
# Gateway endpoints are free and enable private access without NAT Gateway
#
# Benefits:
# - Zero cost (no charge for Gateway endpoints)
# - Reduced NAT Gateway data processing costs
# - Lower latency (direct connection to AWS services)
# - Improved security (traffic stays within AWS network)
#
# Usage:
#   module "s3_vpc_endpoint" {
#     source = "path/to/this/module"
#
#     vpc_id          = "vpc-xxxxx"
#     service_name    = "com.amazonaws.us-east-1.s3"
#     route_table_ids = ["rtb-xxxxx", "rtb-yyyyy"]
#
#     tags = {
#       Environment = "dev"
#     }
#   }
# ======================================================================

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

# ======================================================================
# VPC ENDPOINT GATEWAY RESOURCE
# ======================================================================

resource "aws_vpc_endpoint" "this" {
  vpc_id            = var.vpc_id
  service_name      = var.service_name
  vpc_endpoint_type = "Gateway"

  # Associate with route tables (typically private subnets)
  route_table_ids = var.route_table_ids

  # Optional policy for restricting access
  # If null, defaults to full access
  policy = var.policy

  # Auto-accept the endpoint (for Gateway endpoints, always accepted)
  auto_accept = true

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}
