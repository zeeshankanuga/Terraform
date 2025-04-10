resource "aws_instance" "webservers" {
  count                       = length(var.instance_names)
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  subnet_id                   = aws_subnet.public-subnets[count.index].id
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "${var.instance_names[count.index]}-server"
    Terraform_Managed = "yes"
    ProjectID = var.project_id
  }
}