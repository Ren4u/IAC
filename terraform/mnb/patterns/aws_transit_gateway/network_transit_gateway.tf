locals {
  transit_gateway_id = aws_ec2_transit_gateway.awsregion[0].id 
  transit_gateway_route_table_main_id = aws_ec2_transit_gateway_route_table.static[0].id
  }

resource "aws_ec2_transit_gateway" "awsregion" {
  count                           = var.create_transit_gateway ? 1 : 0
  description                     = format("Transit Gateway for this AWS Region")
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support                     = var.dns_support
  vpn_ecmp_support                = var.vpn_ecmp_support
  tags                            = var.tgw_tags
}

resource "aws_ec2_transit_gateway_route_table" "static" {
  count              = var.create_transit_gateway_static_route_table ? 1 : 0
  transit_gateway_id = local.transit_gateway_id
  tags               = var.staticroutetable_tags 
}

