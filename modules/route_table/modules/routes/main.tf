#Create internet gateway routes
resource "aws_route" "internet_gateway_route" {
  route_table_id              = var.route_table_id
  for_each                    = var.internet_gateway_routes
  destination_cidr_block      = each.value.cidr_block
  gateway_id                  = each.key
}

