#Returns the route tables and a map of the input routes
#At this time, cannot return routes from route table

output "route_table" {
  value = aws_route_table.route_tables
}

#output "routes" {
#  value = {
#    "internet_gateway"             = length(keys(var.internet_gateway_routes)) > 0 ? var.internet_gateway_routes : {} 
#    "egress_only_internet_gateway" = length(keys(var.egress_only_internet_gateway_routes)) > 0 ? var.egress_only_internet_gateway_routes : {} 
#    "vpn_gateway"                  = length(keys(var.vpn_gateway_routes)) > 0 ? var.vpn_gateway_routes : {} 
#    "nat_gateway"                  = length(keys(var.nat_gateway_routes)) > 0 ? var.nat_gateway_routes : {} 
#    "vpc_peering"                  = length(keys(var.vpc_peering_routes)) > 0 ? var.vpc_peering_routes : {} 
#    "vpc_endpoint"                 = length(keys(var.vpc_endpoint_routes)) > 0 ? var.vpc_endpoint_routes : {} 
#    "transit_gateway"              = length(keys(var.transit_gateway_routes)) > 0 ? var.transit_gateway_routes : {} 
#    "carrier_gateway"              = length(keys(var.carrier_gateway_routes)) > 0 ? var.carrier_gateway_routes : {} 
#    "network_interface"            = length(keys(var.network_interface_routes)) > 0 ? var.network_interface_routes : {} 
#  }
#}
