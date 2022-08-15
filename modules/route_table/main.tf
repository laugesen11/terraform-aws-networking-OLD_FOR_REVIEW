#Creates the route table and all defined routes
#
#Current routes it creates:
#  - internet gateway
#  - egress only internet gateway
#  - VPN gateway
#  - transit gateway
#  - NAT gateways
#  - VPC endpoint
#  - VPC peering
#  - Carrier gateways (Wavelength zones)
#  - Network interface ID

resource "aws_route_table" "route_tables"{
  for_each = local.route_table_config
  vpc_id           = each.value.vpc_id
  propagating_vgws = each.value.propagating_vgws
  tags             = each.value.tags
  #vpc_id           = var.vpc_id
  #propagating_vgws = var.propagating_vgws
  #tags             = var.tags
  
  #Set up internet gateway routes
  #dynamic "route" { 
  #  for_each  = var.internet_gateway_routes
  #  content {
  #    cidr_block                 = each.value.cidr_block
  #    ipv6_cidr_block            = each.value.ipv6_cidr_block
  #    destination_prefix_list_id = each.value.destination_prefix_list_id
  #    gateway_id                 = each.key
  #  }
  #}

  #Set up egress only internet gateway routes
  #dynamic route { 
  #  for_each                     = var.egress_only_internet_gateway_routes
  #  content{
  #    ipv6_cidr_block            = each.value.ipv6_cidr_block
  #    destination_prefix_list_id = each.value.destination_prefix_list_id
  #    egress_only_gateway_id     = each.key
  #  }
  #}
  
  #Set up VPN gateway routes
#  dynamic route {
#    for_each                     = var.vpn_gateway_routes
#    content { 
#      cidr_block                 = each.value.cidr_block
#      ipv6_cidr_block            = each.value.ipv6_cidr_block
#      destination_prefix_list_id = each.value.destination_prefix_list_id
#      gateway_id                 = each.key
#    }
#  }
#   
#  #Set up NAT gateway routes
#  dynamic route { 
#    for_each                     = var.nat_gateway_routes
#    content {
#      cidr_block                 = each.value.cidr_block
#      destination_prefix_list_id = each.value.destination_prefix_list_id
#      nat_gateway_id             = each.key
#    }
#  }
#
#  #Set up VPC Peering routes
#  dynamic route {
#    for_each                     = var.vpc_peering_routes
#    content {
#      cidr_block                 = each.value.cidr_block
#      ipv6_cidr_block            = each.value.ipv6_cidr_block
#      destination_prefix_list_id = each.value.destination_prefix_list_id
#      vpc_peering_connection_id  = each.key
#    }
#  }
#  
#  #Set up VPC Endpoint routes
#  dynamic route {
#    for_each                     = var.vpc_endpoint_routes
#    content { 
#      cidr_block                 = each.value.cidr_block
#      ipv6_cidr_block            = each.value.ipv6_cidr_block
#      destination_prefix_list_id = each.value.destination_prefix_list_id
#      vpc_endpoint_id            = each.key
#    }
#  }
#
#  #Set up Transit gateway routes
#  dynamic route {
#    for_each                     = var.transit_gateway_routes
#    content {
#      cidr_block                 = each.value.cidr_block
#      ipv6_cidr_block            = each.value.ipv6_cidr_block
#      destination_prefix_list_id = each.value.destination_prefix_list_id
#      transit_gateway_id         = each.key
#    }
#  }
#  
#  #Set up carrier gateway routes (Wavelength Zone)
#  dynamic route {
#    for_each                     = var.carrier_gateway_routes
#    content {
#      cidr_block                 = each.value.cidr_block
#      ipv6_cidr_block            = each.value.ipv6_cidr_block
#      destination_prefix_list_id = each.value.destination_prefix_list_id
#      carrier_gateway_id         = each.key
#    }
#  }
#
#  #Set up route to Network Interface
#  dynamic route {
#    for_each                     = var.network_interface_routes
#    content {
#      cidr_block                 = each.value.cidr_block
#      ipv6_cidr_block            = each.value.ipv6_cidr_block
#      destination_prefix_list_id = each.value.destination_prefix_list_id
#      network_interface_id       = each.key
#    }
#  }

}

module "routes" {
  source = "./modules/routes"
  for_each = aws_route_table.route_tables
  route_table_id = aws_route_table.route_tables[each.key].id
  internet_gateway_routes = local.internet_gateway_routes[each.key]
  egress_only_internet_gateway_routes = local.egress_only_internet_gateway_routes[each.key]
  vpn_gateway_routes = local.vpn_gateway_routes[each.key]
  nat_gateway_routes = local.nat_gateway_routes[each.key]
  vpc_peering_routes = local.vpc_peering_routes[each.key]
  vpc_endpoint_routes = local.vpc_endpoint_routes[each.key]
  transit_gateway_routes = local.transit_gateway_routes[each.key]
  carrier_gateway_routes = local.carrier_gateway_routes[each.key]
  network_interface_routes = local.network_interface_routes[each.key]
}

#module "internet_gateway_routes" {
#  source = "./modules/routes"
#  for_each = aws_route_table.route_tables
#  route_table_id = aws_route_table.route_tables[each.key].id
#  internet_gateway_routes = local.internet_gateway_routes[each.key]
#}
#Create internet gateway routes
#resource "aws_route" "internet_gateway_route" {
#  route_table_id              = aws_route_table.route_table.id
#  for_each                    = local.internet_gateway_routes
#  destination_cidr_block      = each.value.cidr_block
#  destination_ipv6_cidr_block = each.value.ipv6_cidr_block
#  gateway_id                  = each.key
#}

#Create egress only internet gateway routes
#resource "aws_route" "egress_only_internet_gateway_routes" {
#  route_table_id              = aws_route_table.route_table.id
#  for_each                    = var.egress_only_internet_gateway_routes
#  destination_ipv6_cidr_block = each.value.ipv6_cidr_block
#  gateway_id                  = each.key
#}

#Create vpn gateway routes
#resource "aws_route" "vpn_gateway_routes" {
#  route_table_id              = aws_route_table.route_table.id
#  for_each                    = var.vpn_gateway_routes
#  destination_ipv6_cidr_block = each.value.ipv6_cidr_block
#  destination_cidr_block      = each.value.cidr_block
#  gateway_id                  = each.key
#}

#Create NAT gateway routes
#resource "aws_route" "nat_gateway_routes" {
#  route_table_id              = aws_route_table.route_table.id
#  for_each                    = var.nat_gateway_routes
#  destination_ipv6_cidr_block = each.value.ipv6_cidr_block
#  destination_cidr_block      = each.value.cidr_block
#  gateway_id                  = each.key
#}

#Create VPC peering routes
#resource "aws_route" "vpc_peering_routes" {
#  route_table_id              = aws_route_table.route_table.id
#  for_each                    = var.vpc_peering_routes
#  destination_ipv6_cidr_block = each.value.ipv6_cidr_block
#  destination_cidr_block      = each.value.cidr_block
#  gateway_id                  = each.key
#}

#Creates VPC endpoint routes
#resource "aws_route" "vpc_endpoint_routes" {
#  route_table_id              = aws_route_table.route_table.id
#  for_each                    = var.vpc_endpoint_routes
#  destination_ipv6_cidr_block = each.value.ipv6_cidr_block
#  destination_cidr_block      = each.value.cidr_block
#  gateway_id                  = each.key
#}
