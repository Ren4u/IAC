output "ingressvpc_vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.ingressvpc.*.id, [""])[0]
}

output "ingressvpc_vpc_arn" {
  description = "The ARN of the VPC"
  value       = concat(aws_vpc.ingressvpc.*.arn, [""])[0]
}

output "ingressvpc_vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = concat(aws_vpc.ingressvpc.*.cidr_block, [""])[0]
}

output "ingressvpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = concat(aws_vpc.ingressvpc.*.default_security_group_id, [""])[0]
}

output "ingressvpc_default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = concat(aws_vpc.ingressvpc.*.default_network_acl_id, [""])[0]
}

output "ingressvpc_default_route_table_id" {
  description = "The ID of the default route table"
  value       = concat(aws_vpc.ingressvpc.*.default_route_table_id, [""])[0]
}

output "ingressvpc_vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = concat(aws_vpc.ingressvpc.*.instance_tenancy, [""])[0]
}

output "ingressvpc_vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = concat(aws_vpc.ingressvpc.*.enable_dns_support, [""])[0]
}

output "ingressvpc_vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = concat(aws_vpc.ingressvpc.*.enable_dns_hostnames, [""])[0]
}

output "ingressvpc_vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = concat(aws_vpc.ingressvpc.*.main_route_table_id, [""])[0]
}

output "ingressvpc_private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.ingressvpc_private.*.id
}

output "ingressvpc_private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.ingressvpc_private.*.arn
}

output "ingressvpc_private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = aws_subnet.ingressvpc_private.*.cidr_block
}

output "ingressvpc_public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.ingressvpc_public.*.id
}

output "ingressvpc_public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.ingressvpc_public.*.arn
}

output "ingressvpc_public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = aws_subnet.ingressvpc_public.*.cidr_block
}

output "ingressvpc_public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = aws_route_table.ingressvpc_public.*.id
}

output "ingressvpc_private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.ingressvpc_private.*.id
}

output "ingressvpc_igw_id" {
  description = "The ID of the Internet Gateway"
  value       = concat(aws_internet_gateway.ingressvpc.*.id, [""])[0]
}

# VPC Endpoints

output "ingressvpc_vpc_endpoint_s3_id" {
  description = "The ID of VPC endpoint for S3"
  value       = concat(aws_vpc_endpoint.ingressvpc_s3.*.id, [""])[0]
}

output "ingressvpc_vpc_endpoint_sns_id" {
  description = "The ID of VPC endpoint for SNS"
  value       = concat(aws_vpc_endpoint.ingressvpc_sns.*.id, [""])[0]
}

output "ingressvpc_vpc_endpoint_sns_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for SNS."
  value       = flatten(aws_vpc_endpoint.ingressvpc_sns.*.network_interface_ids)
}

output "ingressvpc_vpc_endpoint_sns_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for SNS."
  value       = flatten(aws_vpc_endpoint.ingressvpc_sns.*.dns_entry)
}

output "ingressvpc_vpc_endpoint_monitoring_id" {
  description = "The ID of VPC endpoint for CloudWatch Monitoring"
  value       = concat(aws_vpc_endpoint.ingressvpc_monitoring.*.id, [""])[0]
}

output "ingressvpc_vpc_endpoint_monitoring_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for CloudWatch Monitoring."
  value       = flatten(aws_vpc_endpoint.ingressvpc_monitoring.*.network_interface_ids)
}

output "ingressvpc_vpc_endpoint_monitoring_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for CloudWatch Monitoring."
  value       = flatten(aws_vpc_endpoint.ingressvpc_monitoring.*.dns_entry)
}

output "ingressvpc_vpc_endpoint_logs_id" {
  description = "The ID of VPC endpoint for CloudWatch Logs"
  value       = concat(aws_vpc_endpoint.ingressvpc_logs.*.id, [""])[0]
}

output "ingressvpc_vpc_endpoint_logs_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for CloudWatch Logs."
  value       = flatten(aws_vpc_endpoint.ingressvpc_logs.*.network_interface_ids)
}

output "ingressvpc_vpc_endpoint_logs_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for CloudWatch Logs."
  value       = flatten(aws_vpc_endpoint.ingressvpc_logs.*.dns_entry)
}

# Static values (arguments)
output "ingressvpc_azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = var.ingressvpc_azs
}

output "ingressvpc_name" {
  description = "The name of the VPC specified as argument to this module"
  value       = var.ingressvpc_name
}