# gcp/iam-service-account-key

Terraform module for Google Cloud iam-service-account-key resource.

## Status
Module structure created following AWS pattern. Implementation pending.

## Structure
- main.tf - Resource definitions with locals for label merging
- variables.tf - Input variables with descriptions, types, defaults, validations
- outputs.tf - Output values with descriptions
- README.md - Documentation with inputs, outputs, examples

## Provider
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

## Next Steps
1. Implement main.tf with google_* resource
2. Define all variables.tf parameters
3. Add relevant outputs.tf
4. Provide usage examples
