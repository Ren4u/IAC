# AWS Access specific variables
aws_region = "ap-southeast-1"

# Application Specifc variables
app_name = "ibanking"
environment = "prod"
appinstance = "SG"
## Ingress VPC Variables
ingressvpc_name = "sg-prod-ibanking-ingress"
ingressvpc_cidr = "10.1.0.128/25"
ingressvpc_public_subnets = ["10.1.0.128/28","10.1.0.144/28","10.1.0.160/28"]
ingressvpc_private_subnets = ["10.1.0.176/28","10.1.0.192/28","10.1.0.208/28"]
ingressvpc_cdn_subnet = ["10.100.125.32/28"]
ingressvpc_public_dedicated_network_acl = "true"
ingressvpc_private_dedicated_network_acl = "true"
## Internal VPC Variables 
internalvpc_name = "sg-prod-ibanking-internal"
internalvpc_cidr = "10.1.1.128/25"
internalvpc_app_private_subnets = ["10.1.1.128/28","10.1.1.144/28","10.1.1.160/28"]
internalvpc_db_private_subnets = ["10.1.1.176/28","10.1.1.192/28","10.1.1.208/28"]
internalvpc_db_dedicated_network_acl = "true"
# Transit Gateway specific variables 
networktgwid = "tgw-04d8cd208d358d764"

# SOA architecture speficic variables 
security_svc_cidr = "10.100.0.0/16"
monitoring_svc_cidr = "10.75.0.0/16"
