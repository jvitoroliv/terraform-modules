data "aws_region" "current" {}

locals {
  awslogs_region = var.awslogs_region != "" ? var.awslogs_region : data.aws_region.current.id

  # Determine if using legacy single container or new multi-container approach
  containers_list = var.container != null ? [var.container] : var.containers

  # Process each container
  container_definitions = [
    for container in local.containers_list : {
      name      = container.name
      image     = container.image
      essential = lookup(container, "essential", true)

      portMappings = [
        for pm in container.port_mappings : {
          containerPort = pm.container_port
          hostPort      = pm.host_port
          protocol      = pm.protocol
        }
      ]

      environment = [
        for k, v in lookup(container, "environment", {}) :
        { name = k, value = v }
      ]

      secrets = concat(
        # SSM secrets from paths
        [
          for p in lookup(container, "ssm_secret_paths", []) :
          { name = basename(p), valueFrom = p }
        ],
        # Direct secrets (for Secrets Manager ARNs)
        lookup(container, "secrets", [])
      )

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = container.log_group_name
          awslogs-region        = local.awslogs_region
          awslogs-stream-prefix = container.name
        }
      }

      # Add command if specified
      command = length(lookup(container, "command", [])) > 0 ? container.command : null
    }
  ]

  # Clean up null values from container definitions
  clean_container_definitions = [
    for container in local.container_definitions :
    {
      for k, v in container :
      k => v if v != null
    }
  ]
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.family
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  cpu                      = tostring(var.cpu)
  memory                   = tostring(var.memory)
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  dynamic "ephemeral_storage" {
    for_each = var.ephemeral_storage_size > 20 ? [1] : []
    content {
      size_in_gib = var.ephemeral_storage_size
    }
  }

  container_definitions = jsonencode(local.clean_container_definitions)

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}
