resource "local_file" "ansible_inventory_file" {
  content = templatefile("publicservers.tpl",
    {
      public_ips  = [for server in aws_instance.webservers : server.public_ip]
      private_ips = [for server in aws_instance.webservers : server.private_ip]
    }
  )
  filename = "${path.module}/ansible_inventory.ini"
}