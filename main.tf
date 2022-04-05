terraform {
  required_version = "= 1.1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.3"
    }
  }

  backend "s3" {
    bucket = "kwsh-terraform-state"
    key = "tgw-centralized-outbound/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      Project     = local.project,
      Environment = local.env,
      Terraform   = true,
    }
  }
}
