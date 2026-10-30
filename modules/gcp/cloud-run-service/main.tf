locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_cloud_run_v2_service" "this" {
  name     = var.name
  location = var.location
  project  = var.project

  description = var.description

  template {
    max_instance_request_concurrency = var.max_instance_request_concurrency
    timeout                          = var.timeout
    service_account                  = var.service_account

    scaling {
      min_instance_count = var.min_instance_count
      max_instance_count = var.max_instance_count
    }

    dynamic "vpc_access" {
      for_each = var.vpc_access != null ? [var.vpc_access] : []
      content {
        connector = try(vpc_access.value.connector, null)
        egress    = try(vpc_access.value.egress, "PRIVATE_RANGES_ONLY")
      }
    }

    containers {
      name  = var.container.name
      image = var.container.image

      dynamic "ports" {
        for_each = var.container.port != null ? [var.container.port] : []
        content {
          name           = var.use_http2 ? "h2c" : null
          container_port = ports.value
        }
      }

      dynamic "env" {
        for_each = var.container.env_vars
        content {
          name  = env.value.name
          value = try(env.value.value, null)

          dynamic "value_source" {
            for_each = try(env.value.secret, null) != null ? [env.value.secret] : []
            content {
              secret_key_ref {
                secret  = value_source.value.secret
                version = value_source.value.version
              }
            }
          }
        }
      }

      resources {
        limits = {
          cpu    = var.container.resources.cpu
          memory = var.container.resources.memory
        }
        cpu_idle          = var.container.resources.cpu_idle
        startup_cpu_boost = var.container.resources.startup_cpu_boost
      }
    }
  }

  labels = local.merged_labels
}

# IAM binding to allow unauthenticated access (optional)
resource "google_cloud_run_v2_service_iam_member" "noauth" {
  count = var.allow_unauthenticated ? 1 : 0

  project  = google_cloud_run_v2_service.this.project
  location = google_cloud_run_v2_service.this.location
  name     = google_cloud_run_v2_service.this.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
