#Declares variables
#
#  Variables included here:
#    - name                                : the name of this route table. Use in future settings
#    - vpc_id                              : the VPC this route table is assigned to
#    - tags                                : tags for this route table
#    - propagating_vgws                    : A list of IDs of virtual private gateways (VPN gateways) to auto propogate for
#NOTE: All the below route variables are intended to be created dynamically, so read carefully the comments around each one 
#      to ensure you include the correct keys/values
#    - internet_gateway_routes             : Map of routes to internet gateways
#    - egress_only_internet_gateway_routes : Map of routes to egress only internet gateways
#    - vpn_gateway_routes                  : Map of routes to VPN gateways
#    - nat_gateway_routes                  : Map of routes to NAT gateways
#    - vpc_peering_routes                  : Map of routes to VPC Peering connections
#    - transit_gateway_routes              : Map of routes to Tansit Gateways 
#    - vpc_endpoints_routes                : Map of routes to VPC Endpoints
#    - carrier_gateway_routes              : Map of routes to Carrier Gateways (Wavelength Zones)
#    - network_interface_routes            : Map of routes to Network interface IDs
#

#Name of route table
#variable "name" {
#  description = "Name of route table to reference in parent modules"
#  type        = string
#}
#
##VPC we are assigning route table to
#variable "vpc_id"{
#  description = "VPC we are assigning route table to"
#  type        = string
#}
#
##Descriptive labels of route table
#variable "tags" {
#  description = "Descriptive labels"
#  type        = map(string)
#}
#
#variable "propagating_vgws" {
#  description = "Sets virtual private (VPN) gateways to auto propogate"
#  type        = list(string)
#  default     = null
#}

variable "vpcs" {
  description = "The VPCs that we can resolve VPC names to"
  default = {}
  type = map
}

#Set up the route tables
variable "route_tables" {
  description = "Defines route tables and their rules"
  default     = null

  type = list(
      object({
        #Name of route table
        name             = string

        #Can be set to VPC name set in this module in vpc_setup variable or external VPC id
        vpc_name_or_id   = string
        propagating_vgws = list(string)
        tags             = map(string)

        routes           = list(object({
            cidr_block                 = string
            ipv6_cidr_block            = string
            destination_prefix_list_id = string
            type                       = string
            destination_name           = string
            destination_id             = string
          })
        )
      })
  )
}

#Input the existing AWS gateways into this module
variable "internet_gateways" {
  description = "Internet gateways we want to route to"
  default = {}
  type = map
}

variable "egress_only_internet_gateways" {
  description = "Egress only internet gateways we want to route to"
  default = {}
  type = map
}

variable "vpn_gateways" {
  description = "VPN gateways we want to route to"
  default = {}
  type = map
}

variable "nat_gateways" {
  description = "NAT gateways we want to route to"
  default = {}
  type = map
}

variable "vpc_peering_connections" {
  description = "VPC Peering connections we want to route to"
  default = {}
  type = map
}

variable "vpc_endpoints" {
  description = "VPC endpoints we want to route to"
  default = {}
  type = map
}

variable "transit_gateways" {
  description = "Transit gateways we want to route to"
  default = {}
  type = map
}


#variable "internet_gateway_routes" {
#  #Expected input:
#  # map[<internet gateway id>] => { 
#  #    Set one of these. Will need more setup for destination_prefix_list_id setting
#  #    "cidr_block"                 = <cidr_block> 
#  #    "destination_prefix_list_id" = <destination_prefix_list_id>
#  #}
#  description = "Routes to internet gateways. Make sure to be in form of: <IGW ID> => {'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
#  type        = map
#}
#
#variable "egress_only_internet_gateway_routes" {
#  #Expected input:
#  # map[<egress only internet gateway id>] => { 
#  #    Set one of these. Will need more setup for destination_prefix_list_id setting
#  #    "ipv6_cidr_block"            = <ipv6_cidr_block> 
#  #    "destination_prefix_list_id" = <destination_prefix_list_id>
#  #}
#  description = "Routes to egress only internet gateways. Make sure to be in form of: <EOIGW ID> => {'ipv6_cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
#  type        = map
#}
#
#variable "vpn_gateway_routes" {
#  #Expected input:
#  # map[<vpn gateway id>] => { 
#  #    Set one of these. Will need more setup for destination_prefix_list_id setting
#  #    "ipv6_cidr_block"            = <ipv6_cidr_block> 
#  #    "cidr_block"                 = <cidr_block> 
#  #    "destination_prefix_list_id" = <destination_prefix_list_id>
#  #}
#  description = "Routes to VPN gateways. Make sure to be in form of: <VPN GW ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
#  type        = map
#}
#
#variable "nat_gateway_routes" {
#  #Expected input:
#  # map[<nat gateway id>] => { 
#  #    Set one of these. Will need more setup for destination_prefix_list_id setting
#  #    NOTE: NAT Gateway only for IPv4
#  #    "cidr_block"                 = <cidr_block> 
#  #    "destination_prefix_list_id" = <destination_prefix_list_id>
#  #}
#  description = "Routes to NAT gateways. Make sure to be in form of: <NAT GW ID> => {'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
#  type        = map
#}
#
#variable "vpc_peering_routes" {
#  #Expected input:
#  # map[<vpc peering id>] => { 
#  #    Set one of these. Will need more setup for destination_prefix_list_id setting
#  #    "ipv6_cidr_block"            = <ipv6_cidr_block> 
#  #    "cidr_block"                 = <cidr_block> 
#  #    "destination_prefix_list_id" = <destination_prefix_list_id>
#  #}
#  description = "Routes to VPC Peering Connections. Make sure to be in form of: <VPC Peering Connection ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
#  type        = map
#}
#
#variable "vpc_endpoint_routes" {
#  #Expected input:
#  # map[<vpc endpoint id>] => { 
#  #    Set one of these. Will need more setup for destination_prefix_list_id setting
#  #    "ipv6_cidr_block"            = <ipv6_cidr_block> 
#  #    "cidr_block"                 = <cidr_block> 
#  #    "destination_prefix_list_id" = <destination_prefix_list_id>
#  #}
#  description = "Routes to VPC Endpoints. Make sure to be in form of: <VPC Endpoint ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
#  type        = map
#}
#
#variable "transit_gateway_routes" {
#  #Expected input:
#  # map[<transit gateway id>] => { 
#  #    Set one of these. Will need more setup for destination_prefix_list_id setting
#  #    "ipv6_cidr_block"            = <ipv6_cidr_block> 
#  #    "cidr_block"                 = <cidr_block> 
#  #    "destination_prefix_list_id" = <destination_prefix_list_id>
#  #}
#  description = "Routes to Transit Gateways. Make sure to be in form of: <Transit GW ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
#  type        = map
#}
#
#variable "carrier_gateway_routes" {
#  #Expected input:
#  # map[<carrier gateway id>] => { 
#  #    Set one of these. Will need more setup for destination_prefix_list_id setting
#  #    "ipv6_cidr_block"            = <ipv6_cidr_block> 
#  #    "cidr_block"                 = <cidr_block> 
#  #    "destination_prefix_list_id" = <destination_prefix_list_id>
#  #}
#  description = "Routes to Carrier Gateways(Wavelength Zones). Make sure to be in form of: <Carrier GW ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
#  type        = map
#}
#
#variable "network_interface_routes" {
#  #Expected input:
#  # map[<network interface id>] => { 
#  #    Set one of these. Will need more setup for destination_prefix_list_id setting
#  #    "ipv6_cidr_block"            = <ipv6_cidr_block> 
#  #    "cidr_block"                 = <cidr_block> 
#  #    "destination_prefix_list_id" = <destination_prefix_list_id>
#  #}
#  description = "Routes to Elastic Network interface (ENI). Make sure to be in form of: <ENI ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
#  type        = map
#}
#
