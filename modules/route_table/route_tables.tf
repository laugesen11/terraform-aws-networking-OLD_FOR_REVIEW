#Creates route tables and routes for specific entities (internet gateway, NAT gateway, etc...)
#Dependancies:
#  - variables.tf - defines VPCs that need egress only internet gateways. 
#    - Reads in:
#      - route_tables variable - sets routes and defines type of route
#
#  - vpc.tf                          - creates VPCs that contain route table and subnets we assign route table to
#  - egress_only_internet_gateway.tf - creates egress only internet gateways used as destinations
#  - internet_gateway.tf             - creates internet gateways used as destinations
#  - nat_gateways.tf                 - creates NAT gatewats used as destination
#  - transit_gateway.tf              - creates transit gateways used as destination
#  - vpc_endpoint.tf                 - creates VPC endpoints used as destination
#  - vpc_peering.tf                  - creates VPC peering connections used as destination
#  - vpn_gateway.tf                  - creates VPN gateways used as destination

locals {
  #Configures the overall settings for the route tables
  route_table_config = {
    for item in var.route_tables: item.name => { 
      #If vpc_name_or_id is set to a VPC name in this module, we use that VPC id. If not, we assume this is an external VPC id
      "vpc_id"           = lookup(var.vpcs,item.vpc_name_or_id,null) != null ? var.vpcs[item.vpc_name_or_id].vpc.id : item.vpc_name_or_id
      "propagating_vgws" = item.propagating_vgws
      "tags"             = merge({"Name" = item.name},item.tags)
    }
  }  

  #Creates map of internet gateway routes from routes with the type of "internet gateway" in variables.tf
  #Can pull the internet gateway ID from internet gateways created in internet_gateways.tf, or specify the ID directly
  internet_gateway_routes = {
    #for item in var.route_tables: item.name => lookup(aws_internet_gateway.internet_gateways,item.vpc_name,null) != null ? {
    for item in var.route_tables: item.name => {
      for route in item.routes: 
        #If destination_id is set, we use that value. If not, we try to use vpc_name_or_id to pull the internet gateway
        route.destination_id != null ? route.destination_id : var.internet_gateways[item.vpc_name_or_id].id =>
        {
          "cidr_block"                 = route.cidr_block
          "destination_prefix_list_id" = route.destination_prefix_list_id
        } if route.type == "internet gateway"
    } 
  }

  #Creates map of egress only internet gateway routes from routes with the type of "egress only internet gateway" in variables.tf
  #Can pull the egress only internet gateway ID from EO internet gateways created in egress_only_internet_gateways.tf, or specify the ID directly
  egress_only_internet_gateway_routes = {
    #for item in var.route_tables: item.name => lookup(aws_egress_only_internet_gateway.egress_only_internet_gateways,item.vpc_name,null) != null ? {
    for item in var.route_tables: item.name => {
      for route in item.routes: 
        #If destination_id is set, we use that value. If not, we try to use vpc_name_or_id to pull the egress only internet gateway
        route.destination_id != null ? route.destination_id : var.egress_only_internet_gateways[item.vpc_name_or_id].id =>
        {
          "ipv6_cidr_block"                 = route.ipv6_cidr_block
          "destination_prefix_list_id"      = route.destination_prefix_list_id
        } if route.type == "egress only internet gateway"
    } 
  }

  #Creates map of VPN gateway routes from routes with the type of "vpn gateway" in variables.tf
  #Can pull the VPN gateway ID from VPN gateways created in vpn_gateways.tf, or specify the ID directly
  vpn_gateway_routes = {
    for item in var.route_tables: item.name => {
      for route in item.routes: 
        #If destination_id is set, we use that value. If not, we try to use vpc_name_or_id to pull the VPN gateway
        route.destination_id != null ? route.destination_id : var.vpn_gateways[item.vpc_name_or_id].id =>
        {
          "ipv6_cidr_block"                 = route.ipv6_cidr_block
          "cidr_block"                      = route.cidr_block
          "destination_prefix_list_id"      = route.destination_prefix_list_id
        } if route.type == "vpn gateway"
    }
  }

  #Creates map of NAT gateway routes from routes with the type of "nat gateway" in variables.tf
  #Can pull the NAT gateway ID from NAT gateways created in nat_gateways.tf, or specify the ID directly
  nat_gateway_routes = {
    for item in var.route_tables: item.name => {
      for route in item.routes: 
        #If destination_id is set, we use that value. If not, we try to use the destination_name to pull the NAT gateway ID
        route.destination_id != null ? route.destination_id : var.nat_gateways[route.destination_name].id =>
        {
          "cidr_block"                      = route.cidr_block
          "destination_prefix_list_id"      = route.destination_prefix_list_id
        } if route.type == "nat gateway"
    } 
  }

  #Creates map of VPC Peering Connection routes from routes with the type of "vpc peering" in variables.tf
  #Can pull the VPC Peering Connection ID from VPC Peering Connection created in vpc_peering.tf, or specify the ID directly
  vpc_peering_routes = {
    for item in var.route_tables: item.name => {
      for route in item.routes: 
        #If destination_id is set, we use that value. If not, we try to use the destination_name to pull the VPC Peering Connection ID
        route.destination_id != null ? route.destination_id : var.vpc_peering_connections[route.destination_name].id =>
        {
          "ipv6_cidr_block"                 = route.ipv6_cidr_block
          "cidr_block"                      = route.cidr_block
          "destination_prefix_list_id"      = route.destination_prefix_list_id
        } if route.type == "vpc peering"
    } 
  }

  #Creates map of VPC Endpoint routes from routes with the type of "vpc endpoint" in variables.tf
  #Can pull the VPC endpoint ID from VPC endpoints created in vpc_endpoint.tf, or specify the ID directly
  vpc_endpoint_routes = {
    for item in var.route_tables: item.name => {
      for route in item.routes: 
        #If destination_id is set, we use that value. If not, we try to use the destination_name to pull the VPC endpoint ID
        route.destination_id != null ? route.destination_id : var.vpc_endpoints[route.destination_name].id =>
        {
          "ipv6_cidr_block"                 = route.ipv6_cidr_block
          "cidr_block"                      = route.cidr_block
          "destination_prefix_list_id"      = route.destination_prefix_list_id
        } if route.type == "vpc endpoint"
    } 
  }

  #Creates map of Transit Gateway routes from routes with the type of "transit gateway" in variables.tf
  #Can pull the Transit gateway ID from transit gateways created in transit_gateways.tf, or specify the ID directly
  transit_gateway_routes = {
    for item in var.route_tables: item.name => {
      for route in item.routes:
        route.destination_id != null ? route.destination_id : var.transit_gateways[route.destination_name].id =>
        {
          "ipv6_cidr_block"                 = route.ipv6_cidr_block
          "cidr_block"                      = route.cidr_block
          "destination_prefix_list_id"      = route.destination_prefix_list_id
        } if route.type == "transit gateway"
    } 
  }

  #Creates map of Carrier Gateway routes (Wavelength Zone) from routes with the type of "carrier gateway" in variables.tf
  #Must specify the destination ID directly
  carrier_gateway_routes = {
    for item in var.route_tables: item.name => {
      for route in item.routes:
        route.destination_id =>
        {
          "ipv6_cidr_block"                 = route.ipv6_cidr_block
          "cidr_block"                      = route.cidr_block
          "destination_prefix_list_id"      = route.destination_prefix_list_id
        } if route.type == "carrier gateway"
    } 
  }
 
  #Creates a map of network interface routes from routes of type "network interface" in variable.tf
  #Must specify the destination ID directly
  network_interface_routes = {
    for item in var.route_tables: item.name => {
      for route in item.routes:
        route.destination_id =>
        {
          "ipv6_cidr_block"                 = route.ipv6_cidr_block
          "cidr_block"                      = route.cidr_block
          "destination_prefix_list_id"      = route.destination_prefix_list_id
        } if route.type == "network interface"
    } 
  }
}

#Moves all local inputs into route table module
#module "route_tables" {
#  source                              = "./modules/route_table"
#  for_each                            = local.route_table_config
#  name                                = each.key
#  vpc_id                              = each.value.vpc_id
#  propagating_vgws                    = each.value.propagating_vgws
#  internet_gateway_routes             = local.route_table_internet_gateway_routes[each.key]
#  egress_only_internet_gateway_routes = local.route_table_egress_only_internet_gateway_routes[each.key]
#  vpn_gateway_routes                  = local.route_table_vpn_gateway_routes[each.key]
#  nat_gateway_routes                  = local.route_table_nat_gateway_routes[each.key]
#  vpc_peering_routes                  = local.route_table_vpc_peering_routes[each.key]
#  vpc_endpoint_routes                 = local.route_table_vpc_endpoint_routes[each.key]
#  transit_gateway_routes              = local.route_table_transit_gateway_routes[each.key]
#  carrier_gateway_routes              = local.route_table_carrier_gateway_routes[each.key]
#  network_interface_routes            = local.route_table_network_interface_routes[each.key]
#  tags                                = each.value.tags
#
#  depends_on = [  
#    aws_internet_gateway.internet_gateways,
#    local.route_table_internet_gateway_routes
#  ]
#}
