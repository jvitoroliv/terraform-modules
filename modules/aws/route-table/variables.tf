variable "vpc_id" {
  description = "VPC ID where the route table will be created."
  type        = string
}

variable "name" {
  description = "Name tag for the route table."
  type        = string
}

variable "routes" {
  description = <<-EOT
    List of routes to add. Each item supports the main targets you typically need.
    Only ONE target should be set per route.

    Example (public RT):
    [
      { cidr_block = "0.0.0.0/0", gateway_id = "igw-abc123" }
    ]

    Example (private RT via NAT):
    [
      { cidr_block = "0.0.0.0/0", nat_gateway_id = "nat-abc123" }
    ]

    Supported fields (all optional except destination):
      - cidr_block (string) OR ipv6_cidr_block (string)
      - gateway_id (string)                         # IGW/VGW
      - nat_gateway_id (string)
      - transit_gateway_id (string)
      - vpc_peering_connection_id (string)
      - egress_only_internet_gateway_id (string)
      - network_interface_id (string)
      - vpc_endpoint_id (string)
      - carrier_gateway_id (string)
      - core_network_arn (string)
      - destination_prefix_list_id (string)
  EOT

  type = list(object({
    cidr_block                       = optional(string)
    ipv6_cidr_block                  = optional(string)
    gateway_id                       = optional(string)
    nat_gateway_id                   = optional(string)
    transit_gateway_id               = optional(string)
    vpc_peering_connection_id        = optional(string)
    egress_only_internet_gateway_id  = optional(string)
    network_interface_id             = optional(string)
    vpc_endpoint_id                  = optional(string)
    carrier_gateway_id               = optional(string)
    core_network_arn                 = optional(string)
    destination_prefix_list_id       = optional(string)
  }))
  default = []
}

variable "propagate_vgw_routes" {
  description = "If true, enables route propagation from attached VPN gateways."
  type        = bool
  default     = false
}

variable "vpn_gateway_id" {
  description = "VPN Gateway ID to use when propagate_vgw_routes is true. Leave null to disable."
  type        = string
  default     = null
}

variable "tags" {
  description = "Extra tags to apply to the route table."
  type        = map(string)
  default     = {}
}
