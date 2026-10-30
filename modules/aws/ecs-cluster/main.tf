locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

resource "aws_ecs_cluster" "this" {
  name = var.name

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  tags = local.merged_tags
}

# Associate FARGATE / FARGATE_SPOT providers and (optionally) set default strategy.
resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name       = aws_ecs_cluster.this.name
  capacity_providers = var.default_capacity_providers

  dynamic "default_capacity_provider_strategy" {
    for_each = var.default_capacity_provider_strategy
    content {
      capacity_provider = default_capacity_provider_strategy.value.capacity_provider
      weight            = try(default_capacity_provider_strategy.value.weight, null)
      base              = try(default_capacity_provider_strategy.value.base, null)
    }
  }
}