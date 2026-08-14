resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

  #   route {
  #     cidr_block = "0.0.0.0/0"
  #     gateway_id = aws_internet_gateway.igw.id
  #   }

  tags = {
    Name              = "${var.vpc_name}-Public-RT"
    environment       = local.environment
    projectID         = local.project_id
    Terraform-Managed = "Yes"
  }
  depends_on = [aws_vpc.vpc, aws_subnet.public-subnets]
}

resource "aws_route" "igw-route" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public-rt-association" {
  count          = length(var.public_subnet_cidrs)
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.public-subnets[count.index].id
}