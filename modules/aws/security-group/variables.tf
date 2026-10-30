variable "name" {
  description = "Security Group name."
  type        = string
}

variable "description" {
  description = "Security Group description."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID where the Security Group will be created."
  type        = string
}

variable "ingress_rules" {
  description = <<-EOT
    List of ingress rules. Each item supports:
      - description (string)
      - from_port (number)
      - to_port (number)
      - protocol (string, e.g., "tcp", "udp", "-1")
      - cidr_blocks (list[string], optional)
      - ipv6_cidr_blocks (list[string], optional)
      - prefix_list_ids (list[string], optional)
      - security_groups (list[string], optional)  # source SGs
      - self (bool, optional)
  EOT
  type = list(object({
    description      = optional(string, "")
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    prefix_list_ids  = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
  default = []
}

variable "egress_rules" {
  description = <<-EOT
    List of egress rules. Same shape as ingress_rules.
  EOT
  type = list(object({
    description      = optional(string, "")
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    prefix_list_ids  = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
  default = [
    # Reasonable default: allow all egress
    {
      description      = "All egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

variable "revoke_rules_on_delete" {
  description = "Revoke SG rules on delete (helps avoid dangling references)."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Extra tags to apply to the Security Group."
  type        = map(string)
  default     = {}
}