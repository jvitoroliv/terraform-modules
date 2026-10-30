# Terraform Backend (S3 + DynamoDB)

Creates the shared remote backend for Terraform:
- **S3** bucket for state files (versioned, encrypted, TLS-only policy)
- **DynamoDB** table for state locking (PITR enabled by default)

> Apply this once per AWS account/region. Other stacks will **reuse** the bucket + table.

## Usage (Manual)

```bash
cd bootstrap/state
terraform init
terraform apply \
  -var "region=sa-east-1" \
  -var "project_name=gameplatform"