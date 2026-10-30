locals {
  indexed = { for idx, a in var.associations : idx => a }
}

resource "aws_route_table_association" "this" {
  for_each = local.indexed

  route_table_id = each.value.route_table_id
  subnet_id      = try(each.value.subnet_id, null)
  gateway_id     = try(each.value.gateway_id, null)

  lifecycle {
    precondition {
      condition     = (try(each.value.subnet_id, null) != null) != (try(each.value.gateway_id, null) != null)
      error_message = "Each association must set exactly one of: subnet_id OR gateway_id."
    }
  }
}