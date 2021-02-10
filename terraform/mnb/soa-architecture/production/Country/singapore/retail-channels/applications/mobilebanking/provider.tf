terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.0"
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_region" "current" {}
