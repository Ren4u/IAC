data "aws_availability_zones" "internalvpc_available" {}

module "internalvpc" {
    source = "../../../../../../../patterns/aws_internal_vpc"

    internalvpc_name = var.internalvpc_name 
    internalvpc_cidr = var.internalvpc_cidr

    internalvpc_azs                      = data.aws_availability_zones.internalvpc_available.names
    internalvpc_app_private_subnets      = var.internalvpc_app_private_subnets
    internalvpc_db_private_subnets       = var.internalvpc_db_private_subnets 
    internalvpc_db_dedicated_network_acl = var.internalvpc_db_dedicated_network_acl

}

locals {
  internalvpc_app_cidr = distinct(concat(var.internalvpc_app_private_subnets))
}


########################
# Database Layer  Network ACLs
########################
resource "aws_network_acl" "internalvpc_database" {
  count = var.create_internal_vpc && var.internalvpc_db_dedicated_network_acl && length(var.internalvpc_db_private_subnets) > 0 ? 1 : 0

  vpc_id     = module.internalvpc.internalvpc_vpc_id
  subnet_ids = module.internalvpc.internalvpc_db_private_subnets

  tags = merge(
    {
      "Name" = format("%s-${var.internalvpc_db_private_subnet_suffix}", var.internalvpc_name)
    },
    var.internalvpc_tags,
  )
}

resource "aws_network_acl_rule" "internalvpc_db_inbound_postgres" {
  count          = length(local.internalvpc_app_cidr)
  network_acl_id = aws_network_acl.internalvpc_database[0].id

  rule_number = 100 + count.index
  egress      = false
  protocol    = "tcp"
  rule_action = "allow"
  from_port   = var.internalvpc_postgre_db_port
  to_port     = var.internalvpc_postgre_db_port
  cidr_block  = local.internalvpc_app_cidr[count.index]
}

resource "aws_network_acl_rule" "internalvpc_db_outbound_postgres" {
  
  count          = length(local.internalvpc_app_cidr)
  network_acl_id = aws_network_acl.internalvpc_database[0].id

  rule_number = 150 + count.index
  egress      = true
  protocol    = "tcp"
  rule_action = "allow"
  from_port   = 0
  to_port     = 65535
  cidr_block  = local.internalvpc_app_cidr[count.index]
}

resource "aws_network_acl_rule" "internalvpc_db_inbound_mysql" {
  count          = length(local.internalvpc_app_cidr)
  network_acl_id = aws_network_acl.internalvpc_database[0].id

  rule_number = 200 + count.index
  egress      = false
  protocol    = "tcp"
  rule_action = "allow"
  from_port   = var.internalvpc_mysql_db_port
  to_port     = var.internalvpc_mysql_db_port
  cidr_block  = local.internalvpc_app_cidr[count.index]
}

resource "aws_network_acl_rule" "internalvpc_db_outbound_mysql" {
  
  count          = length(local.internalvpc_app_cidr)
  network_acl_id = aws_network_acl.internalvpc_database[0].id

  rule_number = 250 + count.index
  egress      = true
  protocol    = "tcp"
  rule_action = "allow"
  from_port   = 0
  to_port     = 65535
  cidr_block  = local.internalvpc_app_cidr[count.index]
}

## Creating Transit Gateway Attachement - Manual work is needed to retrieve the Transit gateway ID from the RAM and update in the tfvasrs file.

data "aws_ec2_transit_gateway" "tgw" {
  id = var.networktgwid
}

resource "aws_ec2_transit_gateway_vpc_attachment" "applayer" {
  subnet_ids         = module.internalvpc.internalvpc_app_private_subnets
  transit_gateway_id = data.aws_ec2_transit_gateway.tgw.id
  vpc_id             = module.internalvpc.internalvpc_vpc_id
  tags               = {
    Name = "${var.appinstance}-${var.app_name}-${var.environment}-internalvpc"
  }
}

# Creation of routes for the application subnet for internal communication.

resource "aws_route" "applayer_internal" {
  route_table_id            =  module.internalvpc.internalvpc_app_route_table_ids[0]
  destination_cidr_block    = "10.0.0.0/8"
  transit_gateway_id        = data.aws_ec2_transit_gateway.tgw.id
  depends_on                = [aws_ec2_transit_gateway_vpc_attachment.applayer]
}






