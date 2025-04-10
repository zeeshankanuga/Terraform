[pub]
%{ for idx, ip in public_ips }
public_server${idx + 1} ansible_port=22 ansible_host=${ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/surya/ansible_testing/devops.pem
%{ endfor }

[pvt]
%{ for idx, ip in private_ips }
private_server${idx + 1} ansible_port=22 ansible_host=${ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/surya/ansible_testing/devops.pem
%{ endfor }

[pip]
%{ for ip in public_ips }
${ip}
%{ endfor }