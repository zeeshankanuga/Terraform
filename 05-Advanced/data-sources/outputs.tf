# ===================================================================
# Outputs — Demonstrates how to consume data source attributes
# ===================================================================

output "latest_amazon_linux_2_ami" {
  description = "The ID and name of the latest Amazon Linux 2 AMI"
  value = {
    id   = data.aws_ami.amazon_linux_2.id
    name = data.aws_ami.amazon_linux_2.name
  }
}

output "availability_zones" {
  description = "List of available AZ names in the current region"
  value       = data.aws_availability_zones.available.names
}

output "default_vpc_id" {
  description = "The ID of the default (or specified) VPC"
  value       = data.aws_vpc.default.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = data.aws_vpc.default.cidr_block
}

output "subnet_count" {
  description = "Number of subnets in the VPC"
  value       = length(data.aws_subnets.all_in_vpc.ids)
}

output "subnet_ids" {
  description = "All subnet IDs in the VPC"
  value       = data.aws_subnets.all_in_vpc.ids
}

output "main_route_table_id" {
  description = "The main route table ID for the VPC"
  value       = data.aws_route_table.main.id
}

output "iam_s3_policy_json" {
  description = "The rendered IAM policy document JSON"
  value       = data.aws_iam_policy_document.s3_readonly.json
}

output "aws_account_id" {
  description = "The current AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_caller_arn" {
  description = "The ARN of the current caller (user/role)"
  value       = data.aws_caller_identity.current.arn
}

output "current_region" {
  description = "The current AWS region name"
  value       = data.aws_region.current.name
}

output "route53_zone" {
  description = "Route53 zone details (if domain_name was provided)"
  value = var.domain_name != null ? {
    id   = data.aws_route53_zone.selected[0].zone_id
    name = data.aws_route53_zone.selected[0].name
  } : null
}