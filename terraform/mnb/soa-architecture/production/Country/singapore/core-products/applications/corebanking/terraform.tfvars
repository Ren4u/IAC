# AWS Access specific variables
aws_region = "ap-southeast-1"

# Application Specifc variables
app_name = "corebanking"
environment = "prod"
appinstance = "SG"
## Internal VPC Variables 
internalvpc_name = "SG-prod-corebanking-internal"
internalvpc_cidr = "10.2.1.0/24"
internalvpc_app_private_subnets = ["10.2.1.0/27","10.2.1.32/27","10.2.1.64/27"]
internalvpc_db_private_subnets = ["10.2.1.96/28","10.2.1.112/28","10.2.1.128/28"]
internalvpc_db_dedicated_network_acl = "true"

# Transit Gateway specific variables 
networktgwid = "tgw-04d8cd208d358d764"
