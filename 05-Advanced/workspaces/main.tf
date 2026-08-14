provider "aws" {
  region = "us-east-1"
  
}


module "EC2" {
    source = "./module/ec2_instance"
    ami_id = var.ami_id
    instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
  
}