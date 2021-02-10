# This Code Repository has terraform code for provisioning and testing a service oriented architecture on AWS Platform.

# Pre requisites before running the code to deploy infrastructure 

- You need to create an AWS Organization and enable resource sharing to share Transit Gateway
- Under your Organization Create Accounts for Network , Ibanking , Mobile Banking , Core Banking , Integration , Security , Monitoring . This is not a definite list , you may create as many accounts as you wish , for example for your CI/CD Applications or any other applications. 

- Enable a user or Role to have programatic access to the accounts to provision infrastructure . This Role or user authentication can use any configurable methods. 

# Deploying the Infrastructure 

I have used set of IPV4 subents from the large private subnet available on AWS , ie 10.0.0.0/8 , same file has been attached as VPC_CIDR in the repository. if you wish to change the subnets , then you may modify the terraform.tfvars file for each infrastructure provisioned below. 

1) Go to the path "IAC/terraform/mnb/soa-architecture/production/Global/east/network" - Run terraform init and apply - provide your User or Role credentials for Network account. 

2) Go to the path "IAC/terraform/mnb/soa-architecture/production/Global/east/integration" - Run terraform init and apply - provide your User or Role credentials for Integration account. 

3) Go to the path "IAC/terraform/mnb/soa-architecture/production/Global/east/monitoring" - Run terraform init and apply - provide your User or Role credentials for Monitoring account. 

4) Go to the path "IAC/terraform/mnb/soa-architecture/production/Global/east/security" - Run terraform init and apply - provide your User or Role credentials for Security account. 

5) Go to the path "IAC/terraform/mnb/soa-architecture/production/Country/singapore/core-products/applications/corebanking" - Run terraform init and apply - provide your User or Role credentials for Core Banking account. 

6) Go to the path "IAC/terraform/mnb/soa-architecture/production/Country/singapore/retail-channels/applications/ibanking" - Run terraform init and apply - provide your User or Role credentials for Ibanking Banking account.

7) Go to the path "IAC/terraform/mnb/soa-architecture/production/Country/singapore/retail-channels/applications/mobilebanking " - Run terraform init and apply - provide your User or Role credentials for Mobile banking Banking account.

## Note 

All of the above steps can be automated from CI/CD Pipeline if you want to do so. 

Have fun deploying applications to these VPC's , integrating , testing . 

