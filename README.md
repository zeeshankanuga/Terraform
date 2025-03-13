**AWS Infrastructure as Code (IaC) with Terraform**

This repository contains Terraform code to provision a robust and scalable AWS infrastructure. The infrastructure includes a Virtual Private Cloud (VPC), public and private subnets, EC2 instances, and an Application Load Balancer (ALB) with a target group. This setup is ideal for deploying highly available and secure applications on AWS.


**Features**

VPC: A Virtual Private Cloud with public and private subnets for secure network isolation.

Public Subnets: Two public subnets across different availability zones for high availability.

Private Subnet: A private subnet for backend services or databases.

EC2 Instances: Instances deployed in public subnets for hosting applications.

Application Load Balancer (ALB): Distributes incoming traffic across multiple instances for improved availability and fault tolerance.

Target Group: Routes traffic to the appropriate instances based on health checks.


**Prerequisites**

Before using this Terraform code, ensure you have the following:

Terraform Installed: Download and install Terraform from here.

AWS Account: An AWS account with necessary permissions to create resources.

AWS CLI: Install and configure the AWS CLI with your credentials using aws configure.

Git: Install Git to clone this repository.
