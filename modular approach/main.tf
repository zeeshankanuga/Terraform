provider "aws" {
  region = "us-east-1"
}

module "ec2" {
   source  = "./module/ec2_instance"

    instance_type = "t2.micro"
    ami           = "ami-04b4f1a9cf54c11d0"

}
