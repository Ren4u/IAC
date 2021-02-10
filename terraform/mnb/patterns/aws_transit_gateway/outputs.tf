output "transit_gateway_arn" {
  value       = try(aws_ec2_transit_gateway.awsregion[0].arn, "")
  description = "Transit Gateway ARN"
}

output "transit_gateway_id" {
  value       = try(aws_ec2_transit_gateway.awsregion[0].id, "")
  description = "Transit Gateway ID"
}

/* output "vpcids" {
  description = "The ID of the VPC"
  value       = concat(data.aws_ec2_transit_gateway_vpc_attachment.tgwdata.vpc_id)
} */