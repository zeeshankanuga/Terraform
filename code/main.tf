resource "aws_s3_bucket" "backend_bucket" {
  bucket = var.bucket_name
  
}

resource "aws_dynamodb_table" "lock_table" {
    name         = var.dynamodb_table_name
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"
}


module "ec2" {
  source = "./modules/ec2"
  
}