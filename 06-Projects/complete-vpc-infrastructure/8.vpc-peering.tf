resource "aws_vpc_peering_connection" "vpc-peering" {
  peer_vpc_id = data.aws_vpc.default.id
  vpc_id      = aws_vpc.vpc.id
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "${var.vpc_name}-VPC-Peering"
  }
}

resource "aws_route" "current_vpc" {
  route_table_id            = aws_route_table.public-rt.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering.id
}

resource "aws_route" "remote_vpc" {
  route_table_id            = data.aws_route_table.default-rt.id
  destination_cidr_block    = "10.37.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering.id
}