# GamePlatform Terraform GCP Modules

Terraform modules for Google Cloud Platform (GCP) following the same pattern as `gameplatform-terraform` AWS modules.

## Overview

This repository contains **40 production-ready Terraform modules** for GCP, organized by service category. All modules follow consistent patterns for variables, outputs, and documentation.

## Module Structure

Each module contains:
- `main.tf` - Resource definitions with locals for label merging
- `variables.tf` - Input variables with descriptions, types, defaults, and validations
- `outputs.tf` - Output values with descriptions
- `README.md` - Module documentation with usage examples

## Provider Requirements

```hcl
terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}
```

## Module Catalog

### Networking (7 modules)

| Module | Description | Status |
|--------|-------------|--------|
| [vpc](modules/gcp/vpc) | VPC network with routing modes | ✅ Complete |
| [subnet](modules/gcp/subnet) | Subnet with secondary IP ranges for GKE | ✅ Complete |
| [cloud-router](modules/gcp/cloud-router) | Cloud Router for NAT/VPN | ✅ Complete |
| [cloud-nat](modules/gcp/cloud-nat) | Cloud NAT for internet access | ✅ Complete |
| [firewall-rule](modules/gcp/firewall-rule) | Firewall rules with allow/deny | ✅ Complete |
| [cloud-dns-zone](modules/gcp/cloud-dns-zone) | Cloud DNS managed zone | ✅ Complete |
| [cloud-dns-record](modules/gcp/cloud-dns-record) | DNS record sets | ✅ Complete |

### Compute (8 modules)

| Module | Description | Status |
|--------|-------------|--------|
| [cloud-run-service](modules/gcp/cloud-run-service) | Cloud Run Gen2 with autoscaling | ✅ Complete |
| [gke-cluster](modules/gcp/gke-cluster) | GKE cluster (Autopilot + Standard) | ✅ Complete |
| [gke-node-pool](modules/gcp/gke-node-pool) | GKE node pool with autoscaling | ✅ Complete |
| [gke-workload-identity](modules/gcp/gke-workload-identity) | GKE Workload Identity binding | ✅ Complete |
| [compute-instance](modules/gcp/compute-instance) | Compute Engine VM instance | ✅ Complete |
| [compute-instance-template](modules/gcp/compute-instance-template) | Instance template for MIGs | ✅ Complete |
| [compute-instance-group](modules/gcp/compute-instance-group) | Managed instance group | ✅ Complete |
| [cloud-functions-v2](modules/gcp/cloud-functions-v2) | Cloud Functions Gen2 | ✅ Complete |

### Database & Storage (6 modules)

| Module | Description | Status |
|--------|-------------|--------|
| [cloud-sql-instance](modules/gcp/cloud-sql-instance) | Cloud SQL PostgreSQL/MySQL | ✅ Complete |
| [cloud-sql-database](modules/gcp/cloud-sql-database) | Cloud SQL database | ✅ Complete |
| [cloud-sql-user](modules/gcp/cloud-sql-user) | Cloud SQL user with password | ✅ Complete |
| [cloud-storage-bucket](modules/gcp/cloud-storage-bucket) | Cloud Storage bucket | ✅ Complete |
| [artifact-registry-repository](modules/gcp/artifact-registry-repository) | Artifact Registry repository | ✅ Complete |
| [firestore-database](modules/gcp/firestore-database) | Firestore NoSQL database | ✅ Complete |

### Load Balancing (6 modules)

| Module | Description | Status |
|--------|-------------|--------|
| [lb-backend-service](modules/gcp/lb-backend-service) | Backend service with health checks | ✅ Complete |
| [lb-url-map](modules/gcp/lb-url-map) | URL map with path routing | ✅ Complete |
| [lb-target-http-proxy](modules/gcp/lb-target-http-proxy) | HTTP target proxy | ✅ Complete |
| [lb-target-https-proxy](modules/gcp/lb-target-https-proxy) | HTTPS target proxy | ✅ Complete |
| [lb-ssl-certificate](modules/gcp/lb-ssl-certificate) | Managed SSL certificate | ✅ Complete |
| [lb-global-forwarding-rule](modules/gcp/lb-global-forwarding-rule) | Global forwarding rule | ✅ Complete |

### IAM & Security (5 modules)

| Module | Description | Status |
|--------|-------------|--------|
| [iam-service-account](modules/gcp/iam-service-account) | Service account creation | ✅ Complete |
| [iam-service-account-key](modules/gcp/iam-service-account-key) | Service account key | ✅ Complete |
| [iam-project-iam-member](modules/gcp/iam-project-iam-member) | Project IAM bindings | ✅ Complete |
| [secret-manager-secret](modules/gcp/secret-manager-secret) | Secret Manager secret | ✅ Complete |
| [secret-manager-secret-version](modules/gcp/secret-manager-secret-version) | Secret version | ✅ Complete |

### Monitoring & Logging (4 modules)

| Module | Description | Status |
|--------|-------------|--------|
| [log-sink](modules/gcp/log-sink) | Log sink to Storage/BigQuery/Pub/Sub | ✅ Complete |
| [monitoring-alert-policy](modules/gcp/monitoring-alert-policy) | Monitoring alert policy | ✅ Complete |
| [monitoring-notification-channel](modules/gcp/monitoring-notification-channel) | Notification channel | ✅ Complete |
| [log-bucket](modules/gcp/log-bucket) | Log bucket configuration | ✅ Complete |

### Extras (4 modules)

| Module | Description | Status |
|--------|-------------|--------|
| [pub-sub-topic](modules/gcp/pub-sub-topic) | Pub/Sub topic | ✅ Complete |
| [pub-sub-subscription](modules/gcp/pub-sub-subscription) | Pub/Sub subscription | ✅ Complete |
| [bigquery-dataset](modules/gcp/bigquery-dataset) | BigQuery dataset | ✅ Complete |
| [bigquery-table](modules/gcp/bigquery-table) | BigQuery table | ✅ Complete |

## Quick Start

### Example: Create VPC and Subnet

```hcl
module "vpc" {
  source = "github.com/example-gamedev-org/gameplatform-terraform-gcp.git//modules/gcp/vpc"

  name    = "gameplatform-vpc"
  project = "gameplatform-prod"

  labels = {
    environment = "production"
    team        = "platform"
  }
}

module "subnet" {
  source = "github.com/example-gamedev-org/gameplatform-terraform-gcp.git//modules/gcp/subnet"

  name          = "gameplatform-subnet"
  network       = module.vpc.self_link
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-east1"

  secondary_ip_ranges = [
    {
      range_name    = "pods"
      ip_cidr_range = "10.1.0.0/16"
    },
    {
      range_name    = "services"
      ip_cidr_range = "10.2.0.0/16"
    }
  ]
}
```

### Example: Deploy Cloud Run Service

```hcl
module "lobby" {
  source = "github.com/example-gamedev-org/gameplatform-terraform-gcp.git//modules/gcp/cloud-run-service"

  name     = "lobby"
  location = "us-east1"
  project  = "gameplatform-prod"

  container = {
    name  = "lobby"
    image = "us-east1-docker.pkg.dev/gameplatform-prod/gameplatform/lobby:latest"
    port  = 3000
    resources = {
      cpu    = "1000m"
      memory = "512Mi"
    }
    env = [
      {
        name  = "NODE_ENV"
        value = "production"
      }
    ]
  }

  allow_unauthenticated = true

  scaling = {
    min_instance_count = 0
    max_instance_count = 10
  }

  labels = {
    environment = "production"
    service     = "frontend"
  }
}
```

### Example: Create GKE Autopilot Cluster

```hcl
module "gke" {
  source = "github.com/example-gamedev-org/gameplatform-terraform-gcp.git//modules/gcp/gke-cluster"

  name     = "gameplatform-gke"
  location = "us-east1"
  project  = "gameplatform-prod"

  enable_autopilot = true

  network    = module.vpc.self_link
  subnetwork = module.subnet.self_link

  ip_allocation_policy = {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  release_channel = "REGULAR"

  labels = {
    environment = "production"
  }
}
```

### Example: Setup Load Balancer

```hcl
# Backend service
module "backend" {
  source = "github.com/example-gamedev-org/gameplatform-terraform-gcp.git//modules/gcp/lb-backend-service"

  name    = "lobby-backend"
  project = "gameplatform-prod"

  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 30

  backends = [
    {
      group = google_compute_region_network_endpoint_group.lobby.id
    }
  ]

  health_check = {
    request_path = "/"
    port         = 3000
  }
}

# URL map
module "url_map" {
  source = "github.com/example-gamedev-org/gameplatform-terraform-gcp.git//modules/gcp/lb-url-map"

  name    = "gameplatform-lb"
  project = "gameplatform-prod"

  default_service = module.backend.self_link
}

# SSL certificate
module "ssl" {
  source = "github.com/example-gamedev-org/gameplatform-terraform-gcp.git//modules/gcp/lb-ssl-certificate"

  name    = "gameplatform-cert"
  project = "gameplatform-prod"

  domains = ["gameplatform.example.com", "*.gameplatform.example.com"]
}

# HTTPS proxy
module "https_proxy" {
  source = "github.com/example-gamedev-org/gameplatform-terraform-gcp.git//modules/gcp/lb-target-https-proxy"

  name             = "gameplatform-https-proxy"
  project          = "gameplatform-prod"
  url_map          = module.url_map.self_link
  ssl_certificates = [module.ssl.self_link]
}

# Global forwarding rule
module "forwarding_rule" {
  source = "github.com/example-gamedev-org/gameplatform-terraform-gcp.git//modules/gcp/lb-global-forwarding-rule"

  name       = "gameplatform-https"
  project    = "gameplatform-prod"
  target     = module.https_proxy.self_link
  port_range = "443"
}
```

## AWS to GCP Module Mapping

| AWS Module | GCP Module | Notes |
|------------|------------|-------|
| `vpc` | `vpc` | Direct equivalent |
| `subnet` | `subnet` | GCP subnets are regional, not zonal |
| `nat-gateway` | `cloud-nat` | GCP Cloud NAT is serverless |
| `internet-gateway` | _VPC default_ | Automatic in GCP VPC |
| `route-table` | `cloud-router` | GCP uses Cloud Router + routes |
| `security-group` | `firewall-rule` | GCP uses VPC firewall rules |
| `alb` | `lb-backend-service` + `lb-url-map` | Multi-module setup |
| `acm-certificate` | `lb-ssl-certificate` | Google-managed SSL |
| `route53-hosted-zone` | `cloud-dns-zone` | Direct equivalent |
| `route53-record` | `cloud-dns-record` | Direct equivalent |
| `ecs-cluster` | `gke-cluster` or `cloud-run-service` | K8s or serverless |
| `ecs-service` | `gke-node-pool` or `cloud-run-service` | Depends on strategy |
| `ecs-task-definition` | K8s `Deployment` | Declarative YAML |
| `ecr-repository` | `artifact-registry-repository` | Direct equivalent |
| `rds` | `cloud-sql-instance` | Direct equivalent |
| `s3-bucket` | `cloud-storage-bucket` | Direct equivalent |
| `iam-role` | `iam-service-account` | GCP uses service accounts |
| `iam-policy` | `iam-project-iam-member` | Project-level bindings |
| `ssm-parameter` | `secret-manager-secret` | GCP Secret Manager |
| `cloudwatch-log-group` | `log-sink` + `log-bucket` | Centralized logging |
| `dynamodb-table` | `firestore-database` | NoSQL document database |

## Module Development Guidelines

### Naming Conventions

- Module names: `kebab-case` (e.g., `cloud-run-service`)
- Resource names: `snake_case` (e.g., `google_cloud_run_v2_service`)
- Variables: `snake_case` (e.g., `min_instance_count`)
- Labels/Tags: `kebab-case` keys (e.g., `environment`, `team`)

### File Structure

```
module-name/
├── main.tf          # Resource definitions
├── variables.tf     # Input variables
├── outputs.tf       # Output values
└── README.md        # Documentation
```

### Best Practices

1. **Use locals for label merging**:
   ```hcl
   locals {
     merged_labels = merge(
       {
         Name = var.name
       },
       var.labels
     )
   }
   ```

2. **Add variable validations**:
   ```hcl
   variable "location" {
     type = string
     validation {
       condition     = can(regex("^(us|europe|asia)-", var.location))
       error_message = "Location must be a valid GCP region or multi-region."
     }
   }
   ```

3. **Use dynamic blocks for optional configs**:
   ```hcl
   dynamic "autoscaling" {
     for_each = var.enable_autoscaling ? [1] : []
     content {
       min_replicas = var.min_replicas
       max_replicas = var.max_replicas
     }
   }
   ```

4. **Provide comprehensive outputs**:
   ```hcl
   output "id" {
     description = "The unique identifier for the resource."
     value       = google_resource.this.id
   }

   output "self_link" {
     description = "The URI of the resource."
     value       = google_resource.this.self_link
   }
   ```

## Testing

Each module can be tested using Terraform's built-in testing framework:

```bash
cd modules/gcp/<module-name>
terraform init
terraform plan -var="name=test" -var="project=test-project"
```

## Contributing

1. Follow the existing module structure
2. Add comprehensive variable descriptions
3. Include usage examples in README.md
4. Test modules before committing

## License

MIT License - See LICENSE file for details

## Support

For issues or questions, please open an issue in the GitHub repository.

---

**Repository**: `gameplatform-terraform-gcp`
**Maintainer**: GamePlatform Platform Team
**Last Updated**: 2025-11-21
**Total Modules**: 40
**Completion Status**: 100% ✅
