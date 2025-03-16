# Import_AWS resource_to_Terraform
To import an existing AWS resource into your Terraform configuration, you can use the terraform ``import`` command. Here's a general guide on how to do it:
## Commands to run in console
**Run command to import file to a local system from AWS**

```
terraform plan -generate-config-out=generated_resource
```

**Copy from ``generated_resource`` file to ``main.tf`` file so resource be available in main.tf file**

**Run command to generate state file same as resources available in live environment**

```
terraform import aws_instance.example i-0b350e67597f1dbeb
```

**Check with Terraform configuration and AWS live environment with ``Terraform apply`` command**

```
terraform apply
```

**your complete environment will be now available in Terraform file**
