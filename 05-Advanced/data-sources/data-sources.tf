# ===================================================================
# Terraform Data Sources — Practical Examples
# ===================================================================
# Data sources allow Terraform to read/query existing infrastructure
# that was created outside of Terraform or in a different state file.
# They are READ-ONLY — they never create or modify resources.
# ===================================================================

# ---------------------------------------------------------------
# 1. AMI Lookup — Find the latest Amazon Linux 2 AMI
# ---------------------------------------------------------------
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# ---------------------------------------------------------------
# 2. Availability Zones — Get all AZs in the current region
# ---------------------------------------------------------------
data "aws_availability_zones" "available" {
  state = "available"
}

# ---------------------------------------------------------------
# 3. VPC Lookup — Get the default VPC (or a specific one)
# ---------------------------------------------------------------
data "aws_vpc" "default" {
  default = var.vpc_id == null ? true : false
  id      = var.vpc_id
}

# ---------------------------------------------------------------
# 4. Subnets — Get all subnets in the VPC found above
# ---------------------------------------------------------------
data "aws_subnets" "all_in_vpc" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "details" {
  for_each = toset(data.aws_subnets.all_in_vpc.ids)
  id       = each.value
}

# ---------------------------------------------------------------
# 5. Route Tables — Get the main/default route table for the VPC
# ---------------------------------------------------------------
data "aws_route_table" "main" {
  vpc_id = data.aws_vpc.default.id
}

# ---------------------------------------------------------------
# 6. Security Groups — Get default SG for the VPC
# ---------------------------------------------------------------
data "aws_security_groups" "vpc_sgs" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ---------------------------------------------------------------
# 7. IAM Policy Document — Build a policy for S3 read-only access
#     (data.aws_iam_policy_document composes JSON policies locally)
# ---------------------------------------------------------------
data "aws_iam_policy_document" "s3_readonly" {
  statement {
    sid    = "S3ReadOnlyAccess"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::example-bucket",
      "arn:aws:s3:::example-bucket/*",
    ]
  }
}

# ---------------------------------------------------------------
# 8. Route53 Zone (optional) — Look up an existing hosted zone
# ---------------------------------------------------------------
data "aws_route53_zone" "selected" {
  count  = var.domain_name != null ? 1 : 0
  name   = var.domain_name
  status = "INSYNC"
}

# ---------------------------------------------------------------
# 9. Current AWS caller identity (account ID, ARN, user)
# ---------------------------------------------------------------
data "aws_caller_identity" "current" {}

# ---------------------------------------------------------------
# 10. Current AWS region metadata
# ---------------------------------------------------------------
data "aws_region" "current" {}