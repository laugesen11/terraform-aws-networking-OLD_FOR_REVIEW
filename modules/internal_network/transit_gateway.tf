#Creates Transit gateways 
#Dependancies:
#  - variables.tf - defines transit gateways
#  Reads in:
#    - transit_gateways variable

locals {
  transit_gateway_config = var.transit_gateways != null ? {
    for item in var.transit_gateways: item.name => {
      "description"                            = item.description
      "amazon_side_asn"                        = item.amazon_side_asn
      "auto_accept_shared_attachments"         = item.auto_accept_shared_attachments
      "enable_default_route_table_association" = item.enable_default_route_table_association
      "enable_default_route_table_propagation" = item.enable_default_route_table_propagation
      "enable_dns_support"                     = item.enable_dns_support
      "enable_vpn_ecmp_support"                = item.enable_vpn_ecmp_support
      "tags"                                   = merge({"Name" = item.name},item.tags)
    } 
  } : {}
}

resource "aws_ec2_transit_gateway" "transit_gateways" {
  for_each                        = local.transit_gateway_config
  description                     = each.value.description
  amazon_side_asn                 = each.value.amazon_side_asn
  auto_accept_shared_attachments  = each.value.auto_accept_shared_attachments ? "enable" : "disable"
  default_route_table_association = each.value.enable_default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = each.value.enable_default_route_table_propagation ? "enable" : "disable"
  dns_support                     = each.value.enable_dns_support ? "enable" : "disable"
  vpn_ecmp_support                = each.value.enable_vpn_ecmp_support ? "enable" : "disable"
  tags                            = each.value.tags
}
