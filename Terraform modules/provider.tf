terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Configure the AWS Backend
terraform {
  backend "s3" {
    bucket  = "surya-ansible-testing"
    key     = "ansible.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}