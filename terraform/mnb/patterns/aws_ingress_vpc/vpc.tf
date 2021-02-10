locals {
  ingressvpc_max_subnet_length = max(
    length(var.ingressvpc_public_subnets),
    length(var.ingressvpc_private_subnets),
  )

ingressvpc_vpc_id = element(
    concat(
      aws_vpc_ipv4_cidr_block_association.ingressvpc.*.vpc_id,
      aws_vpc.ingressvpc.*.id,
      [""],
    ),
    0,
  )

  ingressvpc_vpce_tags = merge(
    var.ingressvpc_tags,
    var.ingressvpc_vpc_endpoint_tags,
  )
  
  ingressvpc_cdn_cidrs = distinct(concat([var.ingressvpc_cdn_subnet]))

}

######
# VPC
######
resource "aws_vpc" "ingressvpc" {
  count = var.create_ingress_vpc ? 1 : 0

  cidr_block                       = var.ingressvpc_cidr
  instance_tenancy                 = var.ingressvpc_instance_tenancy
  enable_dns_hostnames             = var.ingressvpc_enable_dns_hostnames
  enable_dns_support               = var.ingressvpc_enable_dns_support
  enable_classiclink               = var.ingressvpc_enable_classiclink
  enable_classiclink_dns_support   = var.ingressvpc_enable_classiclink_dns_support

  tags = merge(
    {
      "Name" = format("%s", var.ingressvpc_name)
    },
    var.ingressvpc_tags,
    var.ingressvpc_vpc_tags,
  )
}

resource "aws_vpc_ipv4_cidr_block_association" "ingressvpc" {
  count = var.create_ingress_vpc && length(var.ingressvpc_secondary_cidr_blocks) > 0 ? length(var.ingressvpc_secondary_cidr_blocks) : 0

  vpc_id = aws_vpc.ingressvpc[0].id

  cidr_block = element(var.ingressvpc_secondary_cidr_blocks, count.index)
}

###################
# DHCP Options Set
###################
resource "aws_vpc_dhcp_options" "ingressvpc" {
  count = var.create_ingress_vpc && var.ingressvpc_enable_dhcp_options ? 1 : 0

  domain_name          = var.ingressvpc_dhcp_options_domain_name
  domain_name_servers  = var.ingressvpc_dhcp_options_domain_name_servers
  ntp_servers          = var.ingressvpc_dhcp_options_ntp_servers

  tags = merge(
    {
      "Name" = format("%s", var.ingressvpc_name)
    },
    var.ingressvpc_tags,
  )
}

###############################
# DHCP Options Set Association
###############################
resource "aws_vpc_dhcp_options_association" "ingressvpc" {
  count = var.create_ingress_vpc && var.ingressvpc_enable_dhcp_options ? 1 : 0

  vpc_id          = local.ingressvpc_vpc_id
  dhcp_options_id = aws_vpc_dhcp_options.ingressvpc[0].id
}

###################
# Internet Gateway
###################
resource "aws_internet_gateway" "ingressvpc" {
  count = var.create_ingress_vpc && length(var.ingressvpc_public_subnets) > 0 ? 1 : 0

  vpc_id = local.ingressvpc_vpc_id

  tags = merge(
    {
      "Name" = format("%s", var.ingressvpc_name)
    },
    var.ingressvpc_tags,
    var.ingressvpc_igw_tags,
  )
}

################
# Publiс routes
################
resource "aws_route_table" "ingressvpc_public" {
  count = var.create_ingress_vpc && length(var.ingressvpc_public_subnets) > 0 ? 1 : 0

  vpc_id = local.ingressvpc_vpc_id

  tags = merge(
    {
      "Name" = format("%s-${var.ingressvpc_public_subnet_suffix}", var.ingressvpc_name)
    },
    var.ingressvpc_tags,
  )
}

resource "aws_route" "ingressvpc_public_internet_gateway" {
  count = var.create_ingress_vpc && length(var.ingressvpc_public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.ingressvpc_public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ingressvpc[0].id

  timeouts {
    create = "5m"
  }
}

#################
# Private routes
# 
#################
resource "aws_route_table" "ingressvpc_private" {
  count = var.create_ingress_vpc && local.ingressvpc_max_subnet_length > 0 ? 1 : 0

  vpc_id = local.ingressvpc_vpc_id

  tags = merge(
    {
      "Name" = format(
        "%s-${var.ingressvpc_private_subnet_suffix}-%s",
        var.ingressvpc_name,
        element(var.ingressvpc_azs, count.index),
      )
    },
    var.ingressvpc_tags,
  )

}

################
# Public subnet
################

resource "aws_subnet" "ingressvpc_public" {
  count = var.create_ingress_vpc && length(var.ingressvpc_public_subnets) > 0 ? length(var.ingressvpc_public_subnets) : 0

  vpc_id                          = local.ingressvpc_vpc_id
  cidr_block                      = element(concat(var.ingressvpc_public_subnets, [""]), count.index)
  availability_zone               = element(var.ingressvpc_azs, count.index)
  map_public_ip_on_launch         = var.ingressvpc_map_public_ip_on_launch

  tags = merge(
    {
      "Name" = format(
        "%s-${var.ingressvpc_public_subnet_suffix}-%s",
        var.ingressvpc_name,
        element(var.ingressvpc_azs, count.index),
      )
    },
    var.ingressvpc_tags,
  )
}

#################
# Private subnet
#################
resource "aws_subnet" "ingressvpc_private" {
  count = var.create_ingress_vpc && length(var.ingressvpc_private_subnets) > 0 ? length(var.ingressvpc_private_subnets) : 0

  vpc_id                          = local.ingressvpc_vpc_id
  cidr_block                      = var.ingressvpc_private_subnets[count.index]
  availability_zone               = element(var.ingressvpc_azs, count.index)
  
  tags = merge(
    {
      "Name" = format(
        "%s-${var.ingressvpc_private_subnet_suffix}-%s",
        var.ingressvpc_name,
        element(var.ingressvpc_azs, count.index),
      )
    },
    var.ingressvpc_tags,
  )
}

##########################
# Route table association Private subnets
##########################
resource "aws_route_table_association" "ingressvpc_private" {
  count = var.create_ingress_vpc && length(var.ingressvpc_private_subnets) > 0 ? length(var.ingressvpc_private_subnets) : 0

  subnet_id = element(aws_subnet.ingressvpc_private.*.id, count.index)
  route_table_id = aws_route_table.ingressvpc_private[0].id
   
}

##########################
# Route table association Public subnets
##########################

resource "aws_route_table_association" "ingressvpc_public" {
  count = var.create_ingress_vpc && length(var.ingressvpc_public_subnets) > 0 ? length(var.ingressvpc_public_subnets) : 0

  subnet_id      = element(aws_subnet.ingressvpc_public.*.id, count.index)
  route_table_id = aws_route_table.ingressvpc_public[0].id
}







