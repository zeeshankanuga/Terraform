resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name              = "${var.vpc_name}-Private-RT"
    environment       = local.environment
    projectID         = local.project_id
    Terraform-Managed = "Yes"
  }
}

resource "aws_route_table_association" "private-rt-association" {
  count          = length(var.private_subnet_cidrs)
  route_table_id = aws_route_table.private-rt.id
  subnet_id      = aws_subnet.private-subnets[count.index].id
}