#morethanterraform-aws/providers.tf
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "5.31.0" //version no longer required as of terraform 0.14. lock file handles that
    }
  }
}

  provider "aws" {
    #profile = "terraform"
    access_key = var.secret_access_key_id
    secret_key = var.secret_access_key
    region = var.aws_region
  }