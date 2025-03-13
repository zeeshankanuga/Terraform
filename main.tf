resource "aws_vpc" "main" {
    provider = aws.us-east-1
    cidr_block = var.CIDR
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/26"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.64/26"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.128/26"
  availability_zone = "us-east-1c"

  tags = {
    Name = "Private Subnet"
  }
}


resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "Public" {
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "Public RT"
  }
}

resource "aws_route_table" "Private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Private RT"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.Public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.Public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.Private.id
}

resource "aws_security_group" "web" {

  vpc_id = aws_vpc.main.id
    ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "public_instance1" {
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.web.id]
  associate_public_ip_address = true

  tags = {
    Name = "public_instance 1"
  }
}

resource "aws_instance" "public_instance2" {
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.web.id]
  associate_public_ip_address = true

  tags = {
    Name = "public_instance 2"
  }
}

resource "aws_instance" "private_instance" {
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
    Name = "private_instance"
  }
}



#############   LOAD Balancer   #################


resource "aws_lb" "web_lb" {
  name               = "external-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "web_lb_tg" {
  name     = "external-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path     = "/health"
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "web_lb_tg_attachment1" {
  target_group_arn = aws_lb_target_group.web_lb_tg.arn
  target_id        = aws_instance.public_instance1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_lb_tg_attachment2" {
  target_group_arn = aws_lb_target_group.web_lb_tg.arn
  target_id        = aws_instance.public_instance2.id
  port             = 80
}

resource "aws_lb_listener" "listener_alb" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_lb_tg.arn
  }
}