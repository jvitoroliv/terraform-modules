variable "role" {
  description = "Name of the IAM role to attach the policy to."
  type        = string
}

variable "policy_arn" {
  description = "ARN of the IAM policy to attach."
  type        = string
}