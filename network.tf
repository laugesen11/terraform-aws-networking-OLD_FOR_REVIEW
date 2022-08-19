module "network_boundaries" {
  source                          = "./modules/internal_network"
  vpc_setup                       = var.vpc_setup
  nacl_egress_rules               = var.nacl_egress_rules
  nacl_ingress_rules              = var.nacl_ingress_rules
  nat_gateways                    = var.nat_gateways
  vpc_peering                     = var.vpc_peering
  vpc_endpoints                   = var.vpc_endpoints
  transit_gateways                = var.transit_gateways
  transit_gateway_vpc_attachments = var.transit_gateway_vpc_attachments
}

module "route_tables" {
  source                        = "./modules/route_table"
  route_tables                  = var.route_tables
  vpcs                          = module.network_boundaries.vpcs
  internet_gateways             = module.network_boundaries.internet_gateways
  egress_only_internet_gateways = module.network_boundaries.egress_only_internet_gateways
  vpn_gateways                  = module.network_boundaries.vpn_gateways
  nat_gateways                  = module.network_boundaries.nat_gateways
  vpc_peering_connections       = module.network_boundaries.vpc_peering_connections
  vpc_endpoints                 = module.network_boundaries.vpc_endpoints
  transit_gateways              = module.network_boundaries.transit_gateways
}

