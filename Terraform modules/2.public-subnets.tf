resource "aws_subnet" "public-subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  depends_on              = [aws_vpc.vpc]

  tags = {
    Name              = "${var.vpc_name}-PublicSubnet-${count.index + 1}"
    environment       = local.environment
    projectID         = local.project_id
    Terraform-Managed = "Yes"
  }
}