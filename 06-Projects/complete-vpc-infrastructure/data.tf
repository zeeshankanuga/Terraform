data "aws_vpc" "default" {
  id = "vpc-062253e07fb62b78d"
}

data "aws_route_table" "default-rt" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "default-subnet" {
  id = "subnet-034e833a33c2eaf3c"
}