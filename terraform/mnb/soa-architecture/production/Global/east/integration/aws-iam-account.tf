module "iamaccount" {
    source = "../../../../../patterns/aws-iam"

    app_name = var.app_name
    environment = var.environment

}
