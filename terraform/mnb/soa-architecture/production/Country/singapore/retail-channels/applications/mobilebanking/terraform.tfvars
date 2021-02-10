# AWS Access specific variables
aws_region = "ap-southeast-1"

# Application Specifc variables
app_name = "mobile-banking"
environment = "prod"
appinstance = "SG"
## Ingress VPC Variables
ingressvpc_name = "sg-prod-mobilebanking-ingress"
ingressvpc_cidr = "10.1.0.0/25"
ingressvpc_public_subnets = ["10.1.0.0/28","10.1.0.16/28","10.1.0.32/28"]
ingressvpc_private_subnets = ["10.1.0.48/28","10.1.0.64/28","10.1.0.80/28"]
ingressvpc_cdn_subnet = ["10.100.125.32/28"]
ingressvpc_public_dedicated_network_acl = "false"
ingressvpc_private_dedicated_network_acl = "false"
## Internal VPC Variables 
internalvpc_name = "sg-prod-mobile-banking-internal"
internalvpc_cidr = "10.1.1.0/25"
internalvpc_app_private_subnets = ["10.1.1.0/28","10.1.1.16/28","10.1.1.32/28"]
internalvpc_db_private_subnets = ["10.1.1.48/28","10.1.1.64/28","10.1.1.80/28"]
internalvpc_db_dedicated_network_acl = "true"
# Transit Gateway specific variables 
networktgwid = "tgw-04d8cd208d358d764"

# SOA architecture speficic variables 
security_svc_cidr = "10.100.0.0/16"
monitoring_svc_cidr = "10.75.0.0/16"