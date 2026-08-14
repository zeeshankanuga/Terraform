variable "aws_region" {
  description = "The AWS region to query data sources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "Optional: specific VPC ID to look up. If empty, looks up the default VPC."
  type        = string
  default     = null
}

variable "domain_name" {
  description = "Route53 domain name to look up (e.g., example.com)"
  type        = string
  default     = null
}