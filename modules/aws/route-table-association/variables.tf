variable "associations" {
  description = <<-EOT
    List of associations to create. Each association must set either:
      - subnet_id       (for subnet association)
      - gateway_id      (for IGW/VGW association)

    Example:
    [
      { subnet_id = "subnet-aaa", route_table_id = "rtb-111" },
      { subnet_id = "subnet-bbb", route_table_id = "rtb-111" },
      { gateway_id = "igw-xyz",   route_table_id = "rtb-public" }
    ]
  EOT
  type = list(object({
    route_table_id = string
    subnet_id      = optional(string)
    gateway_id     = optional(string)
  }))
}