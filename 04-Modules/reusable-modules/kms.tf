resource "aws_kms_key" "ec2_kms_key" {
    description             = "KMS key for EC2 instance encryption"
  
}

resource "aws_kms_alias" "ec2_kms_alias" {
    name          = "alias/ec2-kms-key"
    target_key_id = aws_kms_key.ec2_kms_key.key_id
}