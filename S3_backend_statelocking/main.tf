provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  
}

resource "aws_s3_bucket" "s3_backend_bucket" {
  bucket = "zeeshan-s3-backend-xyz"

}

resource "aws_dynamodb_table" "terraform_lock" {
  name             = "terraform-lock"
  hash_key         = "lockID"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "lockID"
    type = "S"
  }
}