# gcp/gke-node-pool

Creates a GKE node pool with autoscaling and node configuration.

## Inputs
- `name` (string) - Node pool name
- `location` (string) - GCP region or zone
- `cluster` (string) - GKE cluster name
- `project` (string, optional) - GCP project ID
- `node_count` (number, default `1`) - Initial node count per zone
- `autoscaling` (object) - Autoscaling configuration (min/max nodes)
- `auto_repair` (bool, default `true`) - Enable auto-repair
- `auto_upgrade` (bool, default `true`) - Enable auto-upgrade
- `node_config` (object) - Node configuration (machine_type, disk, labels, taints, etc.)
- `enable_workload_identity` (bool, default `true`) - Enable Workload Identity

## Outputs
- `name` - Node pool name
- `id` - Node pool ID

## Example
```hcl
module "node_pool_general" {
  source = "./modules/gcp/gke-node-pool"

  name     = "general-pool"
  location = "us-east1"
  cluster  = module.gke_cluster.name

  autoscaling = {
    min_node_count = 1
    max_node_count = 5
  }

  node_config = {
    machine_type = "e2-standard-4"
    disk_size_gb = 100
    spot         = true
    labels = {
      workload = "general"
    }
  }
}
```
