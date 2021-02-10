# AWS Access specific variables
aws_region = "ap-southeast-1"

# Application Specifc variables
app_name = "integration"
environment = "prod"
appinstance = "EAST"
## Internal VPC Variables 
internalvpc_name = "EAST-prod-integration-internal"
internalvpc_cidr = "10.25.0.0/22"
internalvpc_app_private_subnets = ["10.25.0.0/24","10.25.1.0/24","10.25.2.0/24"]
internalvpc_db_private_subnets = ["10.25.3.0/26","10.25.3.64/26","10.25.3.128/26"]
internalvpc_db_dedicated_network_acl = "true"

# Transit Gateway specific variables 
networktgwid = "tgw-04d8cd208d358d764"