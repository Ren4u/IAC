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
#####
