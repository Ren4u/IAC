######################
# VPC Endpoint for S3
######################
data "aws_vpc_endpoint_service" "ingressvpc_s3" {
  count = var.create_ingress_vpc && var.ingressvpc_enable_s3_endpoint ? 1 : 0

  service = "s3"
}

resource "aws_vpc_endpoint" "ingressvpc_s3" {
  count = var.create_ingress_vpc && var.ingressvpc_enable_s3_endpoint ? 1 : 0

  vpc_id       = local.ingressvpc_vpc_id
  service_name = data.aws_vpc_endpoint_service.ingressvpc_s3[0].service_name
  tags         = local.ingressvpc_vpce_tags
}

resource "aws_vpc_endpoint_route_table_association" "ingressvpc_private_s3" {
  count = var.create_ingress_vpc && var.ingressvpc_enable_s3_endpoint ? 1 : 0

  vpc_endpoint_id = aws_vpc_endpoint.ingressvpc_s3[0].id
  route_table_id  = element(aws_route_table.ingressvpc_private.*.id, count.index)
}

#######################
# VPC Endpoint for SNS
#######################
data "aws_vpc_endpoint_service" "ingressvpc_sns" {
  count = var.create_ingress_vpc && var.ingressvpc_enable_sns_endpoint ? 1 : 0

  service = "sns"
}

resource "aws_vpc_endpoint" "ingressvpc_sns" {
  count = var.create_ingress_vpc && var.ingressvpc_enable_sns_endpoint ? 1 : 0

  vpc_id            = local.ingressvpc_vpc_id
  service_name      = data.aws_vpc_endpoint_service.ingressvpc_sns[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.ingressvpc_sns_endpoint_security_group_ids
  subnet_ids          = coalescelist(var.ingressvpc_sns_endpoint_subnet_ids, aws_subnet.ingressvpc_private.*.id)
  private_dns_enabled = var.ingressvpc_sns_endpoint_private_dns_enabled
  tags                = local.ingressvpc_vpce_tags
}


#######################
# VPC Endpoint for CloudWatch Monitoring
#######################
data "aws_vpc_endpoint_service" "ingressvpc_monitoring" {
  count = var.create_ingress_vpc && var.ingressvpc_enable_monitoring_endpoint ? 1 : 0

  service = "monitoring"
}

resource "aws_vpc_endpoint" "ingressvpc_monitoring" {
  count = var.create_ingress_vpc && var.ingressvpc_enable_monitoring_endpoint ? 1 : 0

  vpc_id            = local.ingressvpc_vpc_id
  service_name      = data.aws_vpc_endpoint_service.ingressvpc_monitoring[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.ingressvpc_monitoring_endpoint_security_group_ids
  subnet_ids          = coalescelist(var.ingressvpc_monitoring_endpoint_subnet_ids, aws_subnet.ingressvpc_private.*.id)
  private_dns_enabled = var.ingressvpc_monitoring_endpoint_private_dns_enabled
  tags                = local.ingressvpc_vpce_tags
}


#######################
# VPC Endpoint for CloudWatch Logs
#######################
data "aws_vpc_endpoint_service" "ingressvpc_logs" {
  count = var.create_ingress_vpc && var.ingressvpc_enable_logs_endpoint ? 1 : 0

  service = "logs"
}

resource "aws_vpc_endpoint" "ingressvpc_logs" {
  count = var.create_ingress_vpc && var.ingressvpc_enable_logs_endpoint ? 1 : 0

  vpc_id            = local.ingressvpc_vpc_id
  service_name      = data.aws_vpc_endpoint_service.ingressvpc_logs[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.ingressvpc_logs_endpoint_security_group_ids
  subnet_ids          = coalescelist(var.ingressvpc_logs_endpoint_subnet_ids, aws_subnet.ingressvpc_private.*.id)
  private_dns_enabled = var.ingressvpc_logs_endpoint_private_dns_enabled
  tags                = local.ingressvpc_vpce_tags
}
