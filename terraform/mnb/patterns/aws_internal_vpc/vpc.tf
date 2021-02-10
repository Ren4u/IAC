locals {
  internalvpc_max_subnet_length = max(
    length(var.internalvpc_db_private_subnets),
    length(var.internalvpc_app_private_subnets),
  )

internalvpc_vpc_id = element(
    concat(
      aws_vpc_ipv4_cidr_block_association.internalvpc.*.vpc_id,
      aws_vpc.internalvpc.*.id,
      [""],
    ),
    0,
  )

  internalvpc_vpce_tags = merge(
    var.internalvpc_tags,
    var.internalvpc_vpc_endpoint_tags,
  )


}

######
# VPC
######
resource "aws_vpc" "internalvpc" {
  count = var.create_internal_vpc ? 1 : 0

  cidr_block                       = var.internalvpc_cidr
  instance_tenancy                 = var.internalvpc_instance_tenancy
  enable_dns_hostnames             = var.internalvpc_enable_dns_hostnames
  enable_dns_support               = var.internalvpc_enable_dns_support
  enable_classiclink               = var.internalvpc_enable_classiclink
  enable_classiclink_dns_support   = var.internalvpc_enable_classiclink_dns_support

  tags = merge(
    {
      "Name" = format("%s", var.internalvpc_name)
    },
    var.internalvpc_tags,
    var.internalvpc_vpc_tags,
  )
}

resource "aws_vpc_ipv4_cidr_block_association" "internalvpc" {
  count = var.create_internal_vpc && length(var.internalvpc_secondary_cidr_blocks) > 0 ? length(var.internalvpc_secondary_cidr_blocks) : 0

  vpc_id = aws_vpc.internalvpc[0].id

  cidr_block = element(var.internalvpc_secondary_cidr_blocks, count.index)
}

###################
# DHCP Options Set
###################
resource "aws_vpc_dhcp_options" "internalvpc" {
  count = var.create_internal_vpc && var.internalvpc_enable_dhcp_options ? 1 : 0

  domain_name          = var.internalvpc_dhcp_options_domain_name
  domain_name_servers  = var.internalvpc_dhcp_options_domain_name_servers
  ntp_servers          = var.internalvpc_dhcp_options_ntp_servers

  tags = merge(
    {
      "Name" = format("%s", var.internalvpc_name)
    },
    var.internalvpc_tags,
  )
}

###############################
# DHCP Options Set Association
###############################
resource "aws_vpc_dhcp_options_association" "internalvpc" {
  count = var.create_internal_vpc && var.internalvpc_enable_dhcp_options ? 1 : 0

  vpc_id          = local.internalvpc_vpc_id
  dhcp_options_id = aws_vpc_dhcp_options.internalvpc[0].id
}

#################
# Private Application Layer routes
# 
#################
resource "aws_route_table" "internalvpc_app_private" {
  count = var.create_internal_vpc && local.internalvpc_max_subnet_length > 0 ? 1 : 0

  vpc_id = local.internalvpc_vpc_id

  tags = merge(
    {
      "Name" = format(
        "%s-${var.internalvpc_app_private_subnet_suffix}-%s",
        var.internalvpc_name,
        element(var.internalvpc_azs, count.index),
      )
    },
    var.internalvpc_tags,
  )

}

#################
# Private Database Layer routes
# 
#################
resource "aws_route_table" "internalvpc_db_private" {
  count = var.create_internal_vpc && local.internalvpc_max_subnet_length > 0 ? 1 : 0

  vpc_id = local.internalvpc_vpc_id

  tags = merge(
    {
      "Name" = format(
        "%s-${var.internalvpc_db_private_subnet_suffix}-%s",
        var.internalvpc_name,
        element(var.internalvpc_azs, count.index),
      )
    },
    var.internalvpc_tags,
  )

}


#################
# Private Application Layer subnet
#################
resource "aws_subnet" "internalvpc_app_private" {
  count = var.create_internal_vpc && length(var.internalvpc_app_private_subnets) > 0 ? length(var.internalvpc_app_private_subnets) : 0

  vpc_id                          = local.internalvpc_vpc_id
  cidr_block                      = var.internalvpc_app_private_subnets[count.index]
  availability_zone               = element(var.internalvpc_azs, count.index)
  
  tags = merge(
    {
      "Name" = format(
        "%s-${var.internalvpc_app_private_subnet_suffix}-%s",
        var.internalvpc_name,
        element(var.internalvpc_azs, count.index),
      )
    },
    var.internalvpc_tags,
  )
}

#################
# Private Database Layer subnet
#################
resource "aws_subnet" "internalvpc_db_private" {
  count = var.create_internal_vpc && length(var.internalvpc_db_private_subnets) > 0 ? length(var.internalvpc_db_private_subnets) : 0

  vpc_id                          = local.internalvpc_vpc_id
  cidr_block                      = var.internalvpc_db_private_subnets[count.index]
  availability_zone               = element(var.internalvpc_azs, count.index)
  
  tags = merge(
    {
      "Name" = format(
        "%s-${var.internalvpc_db_private_subnet_suffix}-%s",
        var.internalvpc_name,
        element(var.internalvpc_azs, count.index),
      )
    },
    var.internalvpc_tags,
  )
}

##########################
# Route table association Application Layer subnets
##########################
resource "aws_route_table_association" "internalvpc_app_private" {
  count = var.create_internal_vpc && length(var.internalvpc_app_private_subnets) > 0 ? length(var.internalvpc_app_private_subnets) : 0

  subnet_id = element(aws_subnet.internalvpc_app_private.*.id, count.index)
  route_table_id = aws_route_table.internalvpc_app_private[0].id
   
}

##########################
# Route table association Database Layer subnets
##########################
resource "aws_route_table_association" "internalvpc_db_private" {
  count = var.create_internal_vpc && length(var.internalvpc_db_private_subnets) > 0 ? length(var.internalvpc_db_private_subnets) : 0

  subnet_id = element(aws_subnet.internalvpc_db_private.*.id, count.index)
  route_table_id = aws_route_table.internalvpc_db_private[0].id
   
}







