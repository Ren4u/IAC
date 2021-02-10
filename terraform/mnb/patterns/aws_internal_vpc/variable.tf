variable "create_internal_vpc" {
  description = "Controls if VPC should be created "
  type        = bool
  default     = true
}

variable "internalvpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and must force to override"
  type        = string
  default     = "0.0.0.0/0"
}

variable "internalvpc_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "internalvpc_instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "internalvpc_enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "internalvpc_enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "internalvpc_enable_classiclink" {
  description = "Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = null
}

variable "internalvpc_enable_classiclink_dns_support" {
  description = "Should be true to enable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = null
}

variable "internalvpc_azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = []
}

variable "internalvpc_enable_s3_endpoint" {
  description = "Should be true if you want to provision an S3 endpoint to the VPC"
  type        = bool
  default     = false
}

variable "internalvpc_enable_sns_endpoint" {
  description = "Should be true if you want to provision a SNS endpoint to the VPC"
  type        = bool
  default     = false
}

variable "internalvpc_sns_endpoint_private_dns_enabled" {
  description = "Whether or not to associate a private hosted zone with the specified VPC for SNS endpoint"
  type        = bool
  default     = false
}

variable "internalvpc_sns_endpoint_security_group_ids" {
  description = "The ID of one or more security groups to associate with the network interface for SNS endpoint"
  type        = list(string)
  default     = []
}

variable "internalvpc_sns_endpoint_subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for SNS endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used."
  type        = list(string)
  default     = []
}

variable "internalvpc_enable_monitoring_endpoint" {
  description = "Should be true if you want to provision a CloudWatch Monitoring endpoint to the VPC"
  type        = bool
  default     = false
}

variable "internalvpc_monitoring_endpoint_private_dns_enabled" {
  description = "Whether or not to associate a private hosted zone with the specified VPC for SNS endpoint"
  type        = bool
  default     = false
}

variable "internalvpc_monitoring_endpoint_security_group_ids" {
  description = "The ID of one or more security groups to associate with the network interface for CloudWatch Monitoring endpoint"
  type        = list(string)
  default     = []
}

variable "internalvpc_monitoring_endpoint_subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for CloudWatch Monitoring endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used."
  type        = list(string)
  default     = []
}

variable "internalvpc_enable_logs_endpoint" {
  description = "Should be true if you want to provision a CloudWatch Logs endpoint to the VPC"
  type        = bool
  default     = false
}

variable "internalvpc_logs_endpoint_private_dns_enabled" {
  description = "Whether or not to associate a private hosted zone with the specified VPC for SNS endpoint"
  type        = bool
  default     = false
}

variable "internalvpc_logs_endpoint_security_group_ids" {
  description = "The ID of one or more security groups to associate with the network interface for CloudWatch Logs endpoint"
  type        = list(string)
  default     = []
}

variable "internalvpc_logs_endpoint_subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for CloudWatch Logs endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used."
  type        = list(string)
  default     = []
}

variable "internalvpc_enable_cloudtrail_endpoint" {
  description = "Should be true if you want to provision a CloudTrail endpoint to the VPC"
  type        = bool
  default     = false
}

variable "internalvpc_cloudtrail_endpoint_security_group_ids" {
  description = "The ID of one or more security groups to associate with the network interface for CloudTrail endpoint"
  type        = list(string)
  default     = []
}

variable "internalvpc_cloudtrail_endpoint_subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for CloudTrail endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used."
  type        = list(string)
  default     = []
}

variable "internalvpc_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "internalvpc_vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "internalvpc_app_private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}

variable "internalvpc_db_private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}

variable "internalvpc_enable_dhcp_options" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  type        = bool
  default     = false
}

variable "internalvpc_dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
  default     = ""
}

variable "internalvpc_dhcp_options_domain_name_servers" {
  description = "Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

variable "internalvpc_dhcp_options_ntp_servers" {
  description = "Specify a list of NTP servers for DHCP options set (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = []
}

variable "internalvpc_db_dedicated_network_acl" {
  description = "Whether to use dedicated network ACL (not default) and custom rules for private subnets"
  type        = bool
  default     = false
}


variable "internalvpc_app_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "internalvpc_db_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "internalvpc_vpc_endpoint_tags" {
  description = "Additional tags for the VPC Endpoints"
  type        = map(string)
  default     = {}
}


variable "internalvpc_app_private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "apptier2"
}

variable "internalvpc_db_private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "dbtier3"
}

variable "internalvpc_secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = list(string)
  default     = []
}

variable "internalvpc_postgre_db_port" {
  description = " Network Port used to connect postgre SQL database"
  type        = number 
  default     = 5432
}

variable "internalvpc_mysql_db_port" {
  description = " Network Port used to connect  mySQL database"
  type        = number 
  default     = 1433
}







