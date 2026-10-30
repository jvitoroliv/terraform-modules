locals {
  merged_tags = merge({ Name = var.name }, var.tags)
}

resource "aws_ecs_service" "this" {
  name            = var.name
  cluster         = var.cluster_arn
  task_definition = var.task_definition
  desired_count   = var.desired_count

  enable_execute_command = var.enable_execute_command
  platform_version       = var.platform_version

  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent

  # Choose either capacity providers OR launch_type
  dynamic "capacity_provider_strategy" {
    for_each = var.capacity_provider_strategy != null ? var.capacity_provider_strategy : []
    content {
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      weight            = try(capacity_provider_strategy.value.weight, null)
      base              = try(capacity_provider_strategy.value.base, null)
    }
  }

  launch_type = var.capacity_provider_strategy == null ? var.launch_type : null

  network_configuration {
    subnets          = var.network_configuration.subnets
    security_groups  = var.network_configuration.security_groups
    assign_public_ip = var.network_configuration.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = var.load_balancer == null ? [] : [var.load_balancer]
    content {
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }

  dynamic "service_registries" {
    for_each = var.service_registries
    content {
      registry_arn   = service_registries.value.registry_arn
      port           = try(service_registries.value.port, null)
      container_name = try(service_registries.value.container_name, null)
      container_port = try(service_registries.value.container_port, null)
    }
  }

  propagate_tags       = var.propagate_tags
  force_new_deployment = var.force_new_deployment

  tags = local.merged_tags

  lifecycle {
    ignore_changes = [
      desired_count, # keep HPA/ops changes from constantly fighting TF
    ]
  }
}