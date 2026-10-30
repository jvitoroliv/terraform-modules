locals {
  effective_bucket_name = coalesce(
    var.bucket_name,
    "${var.project_name}-${var.region}-tfstate"
  )

  effective_table_name = coalesce(
    var.dynamodb_table_name,
    "${var.project_name}-${var.region}-tf-locks"
  )
}

# --- S3 bucket for Terraform state ------------------------------------------

resource "aws_s3_bucket" "this" {
  bucket        = local.effective_bucket_name
  force_destroy = var.force_destroy

  # AWS now defaults to Object Ownership = Bucket owner enforced
  # (no ACLs needed); we still create explicit resources below.
}

# Prevent any public access at the account+bucket policy level
resource "aws_s3_bucket_public_access_block" "this" {
  count                   = var.block_public_access ? 1 : 0
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Explicit object ownership to avoid ACLs and ensure uniform behavior
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Versioning is strongly recommended for Terraform state
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.enable_bucket_versioning ? "Enabled" : "Suspended"
  }
}

# Server-side encryption (SSE-S3) is enough for state; KMS can be added later if needed
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.enable_bucket_encryption ? 1 : 0
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Simple lifecycle rule: abort incomplete multipart uploads after N days
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "retain-versions-90d"
    status = "Enabled"

    filter {} # <- mandatory when there is no prefix/conditions

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }

  rule {
    id     = "expire-tmp-objects-30d"
    status = "Enabled"

    filter {} # <- idem

    expiration {
      days = 30
    }
  }
}

# (Optional good practice) Enforce TLS for S3 state API calls
data "aws_iam_policy_document" "s3_tls_only" {
  statement {
    sid     = "DenyInsecureTransport"
    effect  = "Deny"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*",
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "tls_only" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.s3_tls_only.json
}

# --- DynamoDB table for Terraform state locking -----------------------------

resource "aws_dynamodb_table" "locks" {
  name         = local.effective_table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = var.dynamodb_point_in_time_recovery
  }
}