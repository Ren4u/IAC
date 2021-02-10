module "transitgw" {
  source = "../../../../../patterns/aws_transit_gateway"

  create_transit_gateway          = var.create_transit_gateway
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support                     = var.dns_support
  vpn_ecmp_support                = var.vpn_ecmp_support
  tgw_tags                        = var.tgw_tags
  ram_name                        = var.ram_name

}
