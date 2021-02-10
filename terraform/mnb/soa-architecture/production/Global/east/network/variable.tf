variable "aws_region" {}
variable "app_name" {}
variable "environment" {}


variable "create_transit_gateway" {
  type        = bool
  default     = true
  description = "Whether to create a Transit Gateway. If set to `false`, an existing Transit Gateway ID must be provided in the variable `existing_transit_gateway_id`"
}

variable "auto_accept_shared_attachments" {
  type        = string
  default     = "enable"
  description = "Whether resource attachment requests are automatically accepted. Valid values: `disable`, `enable`. Default value: `disable`"
}

variable "default_route_table_association" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments are automatically associated with the default association route table. Valid values: `disable`, `enable`. Default value: `enable`"
}

variable "default_route_table_propagation" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: `disable`, `enable`. Default value: `enable`"
}

variable "dns_support" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: `disable`, `enable`. Default value: `enable`"
}

variable "vpn_ecmp_support" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: `disable`, `enable`. Default value: `enable`"
}

variable "tgw_tags" {
    type = map 
    description = " A set of identification tags to attach to the Transit Gateway resource created"
    default = {
        Name   = "AWSSingapore_reg_prod_TGW"
        device = "network_router"
        owner  = "Network technology services"
    }
}

variable "ram_resource_share_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable sharing the Transit Gateway with the Organization using Resource Access Manager (RAM)"
}

variable "ram_principal" {
  type        = string
  default     = null
  description = "The principal to associate with the resource share. Possible values are an AWS account ID, an Organization ARN, or an Organization Unit ARN. If this is not provided and `ram_resource_share_enabled` is set to `true`, the Organization ARN will be used"
}

variable "ram_name" {
  type = string
  description = "The name to be given to RAM resource"
}

variable "allow_external_principals" {
  type        = bool
  default     = false
  description = "Indicates whether principals outside your organization can be associated with a resource share"
}

variable "create_transit_gateway_static_route_table" {
  type        = bool
  default     = true
  description = "Whether to create a Transit Gateway Route Table. If set to `false`, an existing Transit Gateway Route Table ID must be provided in the variable `existing_transit_gateway_route_table_id`"
}

variable "staticroutetable_tags" {
    type = map 
    description = " A set of identification tags to attach to the main route table"
    default = {
        Name = "Static_route_table"
        scope  = "static_routing"
    }
}

