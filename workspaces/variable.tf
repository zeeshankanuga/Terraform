variable "ami_id" {
  description = "value of the AMI ID"
  default = "ami-04b4f1a9cf54c11d0"
  
}

variable "instance_type" {
  description = "value of the instance type"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "test" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}