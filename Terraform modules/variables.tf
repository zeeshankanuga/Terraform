variable "aws_region" {}
variable "environment" {}
variable "project_id" {}
variable "vpc_name" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" {
  type = list(any)
}
variable "azs" {
  type = list(any)
}
variable "private_subnet_cidrs" {
  type = list(any)
}
variable "instance_names" {
  type = list(any)
}
variable "ami" {}
variable "instance_type" {}
variable "key_pair" {}
variable "sg_name" {}
variable "ingress_values" {
  description = "List of ingress rules with port, protocol, and CIDR blocks"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "egress_values" {
  description = "List of egress rules with port, protocol, and CIDR blocks"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}