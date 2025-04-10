resource "aws_subnet" "private-subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  depends_on        = [aws_vpc.vpc]

  tags = {
    Name              = "${var.vpc_name}-privateSubnet-${count.index + 1}"
    environment       = local.environment
    projectID         = local.project_id
    Terraform-Managed = "Yes"
  }
}