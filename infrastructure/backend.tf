provider "aws" {
  region = "eu-central-1"
  profile = "moonactive"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket                  = "moonactive-terraform-state"
    key                     = "global/s3/terraform.tfstate"
    region                  = "eu-central-1"
    profile                 = "moonactive"
    shared_credentials_file = "/home/bear/.aws/credentials"
    dynamodb_table          = "moonactive-terraform-state-locks"
    encrypt                 = true
  }
}
