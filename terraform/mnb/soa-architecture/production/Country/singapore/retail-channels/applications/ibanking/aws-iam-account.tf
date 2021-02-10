module "iamaccount" {
    source = "/Users/ren/Lab/IAC/iac/terraform/aws-iam"

    app_name = var.app_name
    environment = var.environment

}