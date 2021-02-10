# Resource Access Manager (RAM) share for the Transit Gateway
resource "aws_ram_resource_share" "transitgw" {
  count                     = var.ram_resource_share_enabled ? 1 : 0
  name                      = var.ram_name
  allow_external_principals = var.allow_external_principals
  tags                      = var.tgw_tags
}

# Share the Transit Gateway with the Organization if RAM principal was not provided
data "aws_organizations_organization" "default" {
  count = var.ram_resource_share_enabled && (var.ram_principal == null || var.ram_principal == "") ? 1 : 0
}
# Associate Transit gateway to RAM resource share
resource "aws_ram_resource_association" "default" {
  count              = var.ram_resource_share_enabled ? 1 : 0
  resource_arn       = try(aws_ec2_transit_gateway.awsregion[0].arn, "")
  resource_share_arn = try(aws_ram_resource_share.transitgw[0].id, "")
}

# Associate principals with RAM Resource share
resource "aws_ram_principal_association" "default" {
  count              = var.ram_resource_share_enabled ? 1 : 0
  principal          = try(coalesce(var.ram_principal, data.aws_organizations_organization.default[0].arn), "")
  resource_share_arn = try(aws_ram_resource_share.transitgw[0].id, "")
}
