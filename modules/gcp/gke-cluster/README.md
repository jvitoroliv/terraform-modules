# gcp/gke-cluster

Creates a Google Kubernetes Engine (GKE) cluster with support for Autopilot and Standard modes.

## Inputs
- `name` (string) - Cluster name
- `location` (string) - GCP region or zone
- `project` (string, optional) - GCP project ID
- `description` (string, default `""`) - Description
- `enable_autopilot` (bool, default `false`) - Enable Autopilot mode
- `min_master_version` (string, optional) - Minimum GKE version
- `release_channel` (string, default `REGULAR`) - RAPID, REGULAR, STABLE, UNSPECIFIED
- `network` (string) - VPC network self link
- `subnetwork` (string) - VPC subnetwork self link
- `ip_allocation_policy` (object, optional) - VPC-native IP ranges for pods/services
- `private_cluster_config` (object, optional) - Private cluster configuration
- `master_authorized_networks` (list[object], optional) - Master authorized networks
- `enable_workload_identity` (bool, default `true`) - Enable Workload Identity
- `maintenance_window` (object, optional) - Daily maintenance window
- `monitoring_components` (list[string], default `["SYSTEM_COMPONENTS"]`) - Monitoring components
- `enable_managed_prometheus` (bool, default `false`) - Enable managed Prometheus
- `logging_components` (list[string], default `["SYSTEM_COMPONENTS", "WORKLOADS"]`) - Logging components
- `addons_config` (object, optional) - Addons configuration
- `remove_default_node_pool` (bool, default `true`) - Remove default node pool (Standard mode)
- `initial_node_count` (number, default `1`) - Initial node count (Standard mode)
- `deletion_protection` (bool, default `true`) - Enable deletion protection
- `labels` (map, default `{}`) - Resource labels

## Outputs
- `name` - Cluster name
- `id` - Cluster ID
- `endpoint` - Cluster endpoint
- `master_version` - GKE master version
- `cluster_ca_certificate` - Cluster CA certificate (sensitive)
- `location` - Cluster location

## Example - Autopilot Mode
```hcl
module "gke_autopilot" {
  source = "./modules/gcp/gke-cluster"

  name     = "gameplatform-gke-autopilot"
  location = "us-east1"

  enable_autopilot = true
  release_channel  = "REGULAR"

  network    = module.vpc.self_link
  subnetwork = module.subnet.self_link

  ip_allocation_policy = {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  private_cluster_config = {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  labels = {
    environment = "production"
  }
}
```

## Example - Standard Mode with Node Pools
```hcl
module "gke_standard" {
  source = "./modules/gcp/gke-cluster"

  name     = "gameplatform-gke-standard"
  location = "us-east1"

  enable_autopilot = false
  release_channel  = "REGULAR"

  network    = module.vpc.self_link
  subnetwork = module.subnet.self_link

  ip_allocation_policy = {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  remove_default_node_pool = true
  initial_node_count       = 1

  addons_config = {
    http_load_balancing            = true
    horizontal_pod_autoscaling     = true
    gce_persistent_disk_csi_driver = true
  }

  labels = {
    environment = "production"
  }
}
```
