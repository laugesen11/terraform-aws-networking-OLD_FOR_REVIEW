#Creates the route table and all defined routes
#
#Current routes it creates:
#  - internet gateway
#  - egress only internet gateway
#  - VPN gateway
#  - transit gateway
#    - WARNING: Must set up VPC attachment to Transit Gateway for this
#  - NAT gateways
#  - VPC endpoint
#  - VPC peering
#  - Carrier gateways (Wavelength zones)
#  - Network interface ID

resource "aws_route_table" "route_tables"{
  for_each         = local.route_table_config
  vpc_id           = each.value.vpc_id
  propagating_vgws = each.value.propagating_vgws
  tags             = each.value.tags
}

module "routes" {
  source                              = "./modules/routes"
  for_each                            = aws_route_table.route_tables
  route_table_id                      = aws_route_table.route_tables[each.key].id
  vpc_id                              = local.route_table_config[each.key].vpc_id
  internet_gateway_routes             = local.internet_gateway_routes[each.key]
  egress_only_internet_gateway_routes = local.egress_only_internet_gateway_routes[each.key]
  vpn_gateway_routes                  = local.vpn_gateway_routes[each.key]
  nat_gateway_routes                  = local.nat_gateway_routes[each.key]
  vpc_peering_routes                  = local.vpc_peering_routes[each.key]
  vpc_endpoint_routes                 = local.vpc_endpoint_routes[each.key]
  transit_gateway_routes              = local.transit_gateway_routes[each.key]
  carrier_gateway_routes              = local.carrier_gateway_routes[each.key]
  network_interface_routes            = local.network_interface_routes[each.key]
}
