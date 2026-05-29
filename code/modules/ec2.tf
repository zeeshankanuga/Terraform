resource "aws_ec2_instance" "my_ec2" {
  ami           = var.ami_id     #write AMI ID here
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }
}

