provider "aws" {
  region = var.region

  # Global default tags for all resources created here
  default_tags {
    tags = merge(
      {
        Project   = var.project_name
        Component = "terraform-backend"
        ManagedBy = "terraform"
        Env       = "bootstrap"
      },
      var.tags,
    )
  }
}