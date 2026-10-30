locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_cloudfunctions2_function" "this" {
  name        = var.name
  project     = var.project
  location    = var.location
  description = var.description

  build_config {
    runtime     = var.runtime
    entry_point = var.entry_point
    source {
      storage_source {
        bucket = var.source_bucket
        object = var.source_object
      }
    }
    environment_variables = var.build_environment_variables
    docker_repository     = var.docker_repository
    worker_pool           = var.worker_pool
  }

  service_config {
    max_instance_count               = var.max_instance_count
    min_instance_count               = var.min_instance_count
    available_memory                 = var.available_memory
    available_cpu                    = var.available_cpu
    timeout_seconds                  = var.timeout_seconds
    max_instance_request_concurrency = var.max_instance_request_concurrency
    environment_variables            = var.environment_variables
    ingress_settings                 = var.ingress_settings
    all_traffic_on_latest_revision   = var.all_traffic_on_latest_revision
    service_account_email            = var.service_account_email
    vpc_connector                    = var.vpc_connector
    vpc_connector_egress_settings    = var.vpc_connector_egress_settings

    dynamic "secret_environment_variables" {
      for_each = var.secret_environment_variables
      content {
        key        = secret_environment_variables.value.key
        project_id = try(secret_environment_variables.value.project_id, var.project)
        secret     = secret_environment_variables.value.secret
        version    = secret_environment_variables.value.version
      }
    }

    dynamic "secret_volumes" {
      for_each = var.secret_volumes
      content {
        mount_path = secret_volumes.value.mount_path
        project_id = try(secret_volumes.value.project_id, var.project)
        secret     = secret_volumes.value.secret

        dynamic "versions" {
          for_each = secret_volumes.value.versions
          content {
            version = versions.value.version
            path    = versions.value.path
          }
        }
      }
    }
  }

  dynamic "event_trigger" {
    for_each = var.event_trigger != null ? [var.event_trigger] : []
    content {
      trigger_region        = try(event_trigger.value.trigger_region, var.location)
      event_type            = event_trigger.value.event_type
      pubsub_topic          = try(event_trigger.value.pubsub_topic, null)
      service_account_email = try(event_trigger.value.service_account_email, null)
      retry_policy          = try(event_trigger.value.retry_policy, "RETRY_POLICY_RETRY")

      dynamic "event_filters" {
        for_each = try(event_trigger.value.event_filters, [])
        content {
          attribute = event_filters.value.attribute
          value     = event_filters.value.value
          operator  = try(event_filters.value.operator, null)
        }
      }
    }
  }

  labels = local.merged_labels
}

