output "instance_ip" {
  value = aws_ec2_instance.my_ec2.public_ip
}