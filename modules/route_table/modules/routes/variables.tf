variable "route_table_id" {
  description = "The ID of the route table we're adding a route to"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "internet_gateway_routes" {
  #Expected input:
  # map[<internet gateway id>] => {
  #    Set one of these. Will need more setup for destination_prefix_list_id setting
  #    "cidr_block"                 = <cidr_block>
  #    "destination_prefix_list_id" = <destination_prefix_list_id>
  #}
  description = "Routes to internet gateways. Make sure to be in form of: <IGW ID> => {'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
  type        = map
  default     = {}
}

variable "egress_only_internet_gateway_routes" {
  #Expected input:
  # map[<egress only internet gateway id>] => {
  #    Set one of these. Will need more setup for destination_prefix_list_id setting
  #    "ipv6_cidr_block"            = <ipv6_cidr_block>
  #    "destination_prefix_list_id" = <destination_prefix_list_id>
  #}
  description = "Routes to egress only internet gateways. Make sure to be in form of: <EOIGW ID> => {'ipv6_cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
  type        = map
  default     = {}
}

variable "vpn_gateway_routes" {
  #Expected input:
  # map[<vpn gateway id>] => {
  #    Set one of these. Will need more setup for destination_prefix_list_id setting
  #    "ipv6_cidr_block"            = <ipv6_cidr_block>
  #    "cidr_block"                 = <cidr_block>
  #    "destination_prefix_list_id" = <destination_prefix_list_id>
  #}
  description = "Routes to VPN gateways. Make sure to be in form of: <VPN GW ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
  type        = map
  default     = {}
}

variable "nat_gateway_routes" {
  #Expected input:
  # map[<nat gateway id>] => {
  #    Set one of these. Will need more setup for destination_prefix_list_id setting
  #    NOTE: NAT Gateway only for IPv4
  #    "cidr_block"                 = <cidr_block>
  #    "destination_prefix_list_id" = <destination_prefix_list_id>
  #}
  description = "Routes to NAT gateways. Make sure to be in form of: <NAT GW ID> => {'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
  type        = map
  default     = {}
}

variable "vpc_peering_routes" {
  #Expected input:
  # map[<vpc peering id>] => {
  #    Set one of these. Will need more setup for destination_prefix_list_id setting
  #    "ipv6_cidr_block"            = <ipv6_cidr_block>
  #    "cidr_block"                 = <cidr_block>
  #    "destination_prefix_list_id" = <destination_prefix_list_id>
  #}
  description = "Routes to VPC Peering Connections. Make sure to be in form of: <VPC Peering Connection ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
  type        = map
  default     = {}
}

variable "vpc_endpoint_routes" {
  #Expected input:
 # map[<vpc endpoint id>] => {
  #    Set one of these. Will need more setup for destination_prefix_list_id setting
  #    "ipv6_cidr_block"            = <ipv6_cidr_block>
  #    "cidr_block"                 = <cidr_block>
  #    "destination_prefix_list_id" = <destination_prefix_list_id>
  #}
  description = "Routes to VPC Endpoints. Make sure to be in form of: <VPC Endpoint ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
  type        = map
  default     = {}
}

variable "transit_gateway_routes" {
  #Expected input:
  # map[<transit gateway id>] => {
  #    Set one of these. Will need more setup for destination_prefix_list_id setting
  #    "ipv6_cidr_block"            = <ipv6_cidr_block>
  #    "cidr_block"                 = <cidr_block>
  #    "destination_prefix_list_id" = <destination_prefix_list_id>
  #}
  description = "Routes to Transit Gateways. Make sure to be in form of: <Transit GW ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
  type        = map
  default     = {}
}

variable "carrier_gateway_routes" {
  #Expected input:
  # map[<carrier gateway id>] => {
  #    Set one of these. Will need more setup for destination_prefix_list_id setting
  #    "ipv6_cidr_block"            = <ipv6_cidr_block>
  #    "cidr_block"                 = <cidr_block>
  #    "destination_prefix_list_id" = <destination_prefix_list_id>
  #}
  description = "Routes to Carrier Gateways(Wavelength Zones). Make sure to be in form of: <Carrier GW ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
  default     = {}
}

variable "network_interface_routes" {
  #Expected input:
  # map[<network interface id>] => {
  #    Set one of these. Will need more setup for destination_prefix_list_id setting
  #    "ipv6_cidr_block"            = <ipv6_cidr_block>
  #    "cidr_block"                 = <cidr_block>
  #    "destination_prefix_list_id" = <destination_prefix_list_id>
  #}
  description = "Routes to Elastic Network interface (ENI). Make sure to be in form of: <ENI ID> => {'ipv6_cidr_block' = [<string>|null], 'cidr_block' = [<string>|null], 'destination_prefix_list_id' = [<string>|null]}"
  type        = map
  default     = {}
}

