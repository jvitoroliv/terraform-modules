variable "name" {
  description = "IAM policy name."
  type        = string
}

variable "description" {
  description = "Description of the IAM policy."
  type        = string
  default     = ""
}

variable "path" {
  description = "Path for the IAM policy."
  type        = string
  default     = "/"
}

variable "policy" {
  description = <<-EOT
    JSON IAM policy document. Example:
    jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Effect   = "Allow",
        Action   = ["s3:ListAllMyBuckets"],
        Resource = "*"
      }]
    })
  EOT
  type = string
}

variable "tags" {
  description = "Extra tags for the policy."
  type        = map(string)
  default     = {}
}