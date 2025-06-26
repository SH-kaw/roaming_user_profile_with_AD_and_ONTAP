#バージョンを指定
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.12.2"
}

#AWSの情報
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

