resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name              = var.vpc_name
    environment       = local.environment
    projectID         = local.project_id
    Terraform-Managed = "Yes"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name              = "${var.vpc_name}-IGW"
    environment       = local.environment
    projectID         = local.project_id
    Terraform-Managed = "Yes"
  }
  depends_on = [aws_vpc.vpc]
}