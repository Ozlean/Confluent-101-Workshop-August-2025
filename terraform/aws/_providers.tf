terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6" # or latest available
    }

  }
}


provider "aws" {
  region = "eu-west-1"
  access_key = var.AWS_workshop_terraform_user_key
  secret_key = var.AWS_workshop_terraform_user_secret
}







