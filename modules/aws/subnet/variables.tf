variable "vpc_id" {
  description = "The VPC ID where subnets will be created."
  type        = string
}

variable "subnets" {
  description = <<-EOT
    List of subnet specifications to create. Each element supports:
      - cidr_block (string)                 [required]
      - availability_zone (string | null)   [optional; if null, AZs are chosen in order]
      - name (string)                        [required]
      - map_public_ip_on_launch (bool)       [optional; default false]
  EOT
  type = list(object({
    cidr_block              = string
    availability_zone       = optional(string)
    name                    = string
    map_public_ip_on_launch = optional(bool, false)
  }))
}

variable "tags" {
  description = "Extra tags applied to each subnet."
  type        = map(string)
  default     = {}
}