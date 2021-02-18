terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.0"
  }
}

  provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_iam_account_alias" "alias" {
  count         = length(var.app_name) > 0 ? 1 : 0
  account_alias = "mnb-${var.environment}-${var.app_name}"
}
