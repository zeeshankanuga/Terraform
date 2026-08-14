terraform {
  backend "s3" {
    bucket = "zeeshan-s3-backend-xyz"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}