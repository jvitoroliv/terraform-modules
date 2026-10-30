output "role" {
  description = "Role name the policy is attached to."
  value       = var.role
}

output "policy_arn" {
  description = "ARN of the policy that was attached."
  value       = var.policy_arn
}