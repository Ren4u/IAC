######################
# VPC Endpoint for S3
######################
data "aws_vpc_endpoint_service" "internalvpc_s3" {
  count = var.create_internal_vpc && var.internalvpc_enable_s3_endpoint ? 1 : 0

  service = "s3"
}

resource "aws_vpc_endpoint" "internalvpc_s3" {
  count = var.create_internal_vpc && var.internalvpc_enable_s3_endpoint ? 1 : 0

  vpc_id       = local.internalvpc_vpc_id
  service_name = data.aws_vpc_endpoint_service.internalvpc_s3[0].service_name
  tags         = local.internalvpc_vpce_tags
}

resource "aws_vpc_endpoint_route_table_association" "internalvpc_private_s3" {
  count = var.create_internal_vpc && var.internalvpc_enable_s3_endpoint ? 1 : 0

  vpc_endpoint_id = aws_vpc_endpoint.internalvpc_s3[0].id
  route_table_id  = element(aws_route_table.internalvpc_app_private.*.id, count.index)
}

#######################
# VPC Endpoint for SNS
#######################
data "aws_vpc_endpoint_service" "internalvpc_sns" {
  count = var.create_internal_vpc && var.internalvpc_enable_sns_endpoint ? 1 : 0

  service = "sns"
}

resource "aws_vpc_endpoint" "internalvpc_sns" {
  count = var.create_internal_vpc && var.internalvpc_enable_sns_endpoint ? 1 : 0

  vpc_id            = local.internalvpc_vpc_id
  service_name      = data.aws_vpc_endpoint_service.internalvpc_sns[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.internalvpc_sns_endpoint_security_group_ids
  subnet_ids          = coalescelist(var.internalvpc_sns_endpoint_subnet_ids, aws_subnet.internalvpc_app_private.*.id)
  private_dns_enabled = var.internalvpc_sns_endpoint_private_dns_enabled
  tags                = local.internalvpc_vpce_tags
}


#######################
# VPC Endpoint for CloudWatch Monitoring
#######################
data "aws_vpc_endpoint_service" "internalvpc_monitoring" {
  count = var.create_internal_vpc && var.internalvpc_enable_monitoring_endpoint ? 1 : 0

  service = "monitoring"
}

resource "aws_vpc_endpoint" "internalvpc_monitoring" {
  count = var.create_internal_vpc && var.internalvpc_enable_monitoring_endpoint ? 1 : 0

  vpc_id            = local.internalvpc_vpc_id
  service_name      = data.aws_vpc_endpoint_service.internalvpc_monitoring[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.internalvpc_monitoring_endpoint_security_group_ids
  subnet_ids          = coalescelist(var.internalvpc_monitoring_endpoint_subnet_ids, aws_subnet.internalvpc_app_private.*.id)
  private_dns_enabled = var.internalvpc_monitoring_endpoint_private_dns_enabled
  tags                = local.internalvpc_vpce_tags
}


#######################
# VPC Endpoint for CloudWatch Logs
#######################
data "aws_vpc_endpoint_service" "internalvpc_logs" {
  count = var.create_internal_vpc && var.internalvpc_enable_logs_endpoint ? 1 : 0

  service = "logs"
}

resource "aws_vpc_endpoint" "internalvpc_logs" {
  count = var.create_internal_vpc && var.internalvpc_enable_logs_endpoint ? 1 : 0

  vpc_id            = local.internalvpc_vpc_id
  service_name      = data.aws_vpc_endpoint_service.internalvpc_logs[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.internalvpc_logs_endpoint_security_group_ids
  subnet_ids          = coalescelist(var.internalvpc_logs_endpoint_subnet_ids, aws_subnet.internalvpc_app_private.*.id)
  private_dns_enabled = var.internalvpc_logs_endpoint_private_dns_enabled
  tags                = local.internalvpc_vpce_tags
}
