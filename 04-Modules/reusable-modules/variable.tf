variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-0c5461e7b9f38a3d8" #write AMI ID here
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name tag for the EC2 instance"
  type        = string
  default     = "MyEC2Instance"
}