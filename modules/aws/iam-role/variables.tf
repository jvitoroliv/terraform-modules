variable "name" {
  description = "IAM Role name."
  type        = string
}

variable "path" {
  description = "IAM path for the role."
  type        = string
  default     = "/"
}

variable "description" {
  description = "Role description."
  type        = string
  default     = ""
}

variable "assume_role_policy" {
  description = <<-EOT
    Full trust policy JSON. If provided, it takes precedence over assume_role_principal.
    Example: jsonencode({ Version = "2012-10-17", Statement = [...] })
  EOT
  type    = string
  default = ""
}

variable "assume_role_principal" {
  description = <<-EOT
    Convenience principal to build a default trust policy.
    Examples:
      - "ecs-tasks.amazonaws.com"
      - "ec2.amazonaws.com"
      - "lambda.amazonaws.com"
  EOT
  type    = string
  default = ""
}

variable "max_session_duration" {
  description = "Maximum session duration in seconds (3600–43200)."
  type        = number
  default     = 3600
}

variable "permissions_boundary" {
  description = "Optional permissions boundary policy ARN."
  type        = string
  default     = ""
}

variable "inline_policies" {
  description = <<-EOT
    Map of inline policy JSON documents. Key is the policy name, value is json string.
    Example:
      {
        "read-ssm" = jsonencode({
          Version = "2012-10-17",
          Statement = [{
            Effect = "Allow",
            Action = ["ssm:GetParameter"],
            Resource = "arn:aws:ssm:us-east-1:999999999999:parameter/gameplatform/*"
          }]
        })
      }
  EOT
  type    = map(string)
  default = {}
}

variable "tags" {
  description = "Tags to apply to the role."
  type        = map(string)
  default     = {}
}