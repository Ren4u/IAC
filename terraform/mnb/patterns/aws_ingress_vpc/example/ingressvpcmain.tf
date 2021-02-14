data "aws_availability_zones" "ingressvpc_available" {}


module "ingressvpc" {
  source = "../../../../../../../patterns/aws_ingress_vpc"

  ingressvpc_name = var.ingressvpc_name
  ingressvpc_cidr = var.ingressvpc_cidr

  ingressvpc_azs             = data.aws_availability_zones.ingressvpc_available.names
  ingressvpc_public_subnets  = var.ingressvpc_public_subnets
  ingressvpc_private_subnets = var.ingressvpc_private_subnets
  ingressvpc_cdn_subnet      = var.ingressvpc_cdn_subnet

  ingressvpc_private_dedicated_network_acl = var.ingressvpc_private_dedicated_network_acl
  ingressvpc_public_dedicated_network_acl  = var.ingressvpc_public_dedicated_network_acl

}

locals {
  ingressvpc_cdn_cidrs      = distinct(concat(var.ingressvpc_cdn_subnet))
  ingressvpc_dmztier0_cidrs = distinct(concat(var.ingressvpc_public_subnets))
}

## Creating Transit Gateway Attachement - Manual work is needed to retrieve the Transit gateway ID from the RAM and update in the tfvars file.

resource "aws_ec2_transit_gateway_vpc_attachment" "tier1layer" {
  subnet_ids         = module.ingressvpc.ingressvpc_private_subnets
  transit_gateway_id = data.aws_ec2_transit_gateway.tgw.id
  vpc_id             = module.ingressvpc.ingressvpc_vpc_id
  tags = {
    Name = "${var.appinstance}-${var.app_name}-${var.environment}-ingressvpc"
  }
}

# Creation of routes for the web tier1 private subnet to connect to internal Application VPC 

resource "aws_route" "tier1weblayer_to_applayer" {
  route_table_id         = module.ingressvpc.ingressvpc_private_route_table_ids[0]
  destination_cidr_block = module.internalvpc.internalvpc_vpc_cidr_block
  transit_gateway_id     = data.aws_ec2_transit_gateway.tgw.id
  depends_on             = [aws_ec2_transit_gateway_vpc_attachment.tier1layer]
}

resource "aws_route" "tier1weblayer_to_securitysvcvpc" {
  route_table_id         = module.ingressvpc.ingressvpc_private_route_table_ids[0]
  destination_cidr_block = var.security_svc_cidr
  transit_gateway_id     = data.aws_ec2_transit_gateway.tgw.id
  depends_on             = [aws_ec2_transit_gateway_vpc_attachment.tier1layer]
}

resource "aws_route" "tier1weblayer_to_monitoringsvcvpc" {
  route_table_id         = module.ingressvpc.ingressvpc_private_route_table_ids[0]
  destination_cidr_block = var.monitoring_svc_cidr
  transit_gateway_id     = data.aws_ec2_transit_gateway.tgw.id
  depends_on             = [aws_ec2_transit_gateway_vpc_attachment.tier1layer]
}



