terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "lockID"
    region = "ap-southeast-1"
    dynamodb_table = "my-terraform-lock-table"
  }
}