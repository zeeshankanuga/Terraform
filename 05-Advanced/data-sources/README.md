# Terraform Data Sources 📡

## What Are Data Sources?

A **data source** in Terraform lets you **read** or **query** infrastructure that already exists — whether it was created by Terraform, manually through the AWS Console, or by another tool.

```hcl
data "aws_vpc" "default" {
  default = true
}
```

Think of it like running `aws ec2 describe-vpcs` from the CLI — you're fetching information, not creating anything.

### Data Sources vs Resources

| Aspect | `data` (Data Source) | `resource` (Resource) |
|---|---|---|
| **Creates something?** | ❌ No — read-only query | ✅ Yes — provisions infrastructure |
| **Can it fail?** | ✅ Yes — if the queried item doesn't exist | ✅ Yes — if provisioning fails |
| **Lifecycle** | Refreshed every `plan`/`apply` | Created once, updated on changes |
| **State** | Stored in state file for reference | Stored in state file as truth |
| **When to use** | You need info about existing infra | You need to create/modify infra |

## Why Use Data Sources?

| Use Case | Example |
|---|---|
| **Fetch dynamic IDs** | Get the latest Amazon Linux 2 AMI ID without hardcoding it |
| **Reference existing infra** | Look up the default VPC or existing subnets |
| **Avoid hardcoding** | Get AZs dynamically: `data.aws_availability_zones.available.names[0]` |
| **Cross-project lookups** | Read an S3 bucket created in another Terraform workspace |
| **IAM policy composition** | Build JSON policies with `data.aws_iam_policy_document` |
| **Current context** | Get your AWS account ID, caller ARN, or current region |

## Examples in This Folder

| # | Data Source | What It Does |
|---|---|---|
| 1 | `aws_ami` | Finds the latest Amazon Linux 2 AMI |
| 2 | `aws_availability_zones` | Returns all available AZs in the region |
| 3 | `aws_vpc` | Looks up the default VPC (or a specific one by ID) |
| 4 | `aws_subnets` | Finds all subnets inside that VPC |
| 5 | `aws_route_table` | Gets the main route table for the VPC |
| 6 | `aws_security_groups` | Lists all security groups in the VPC |
| 7 | `aws_iam_policy_document` | Composes a JSON IAM policy for S3 read-only access |
| 8 | `aws_route53_zone` | Looks up an existing Route53 hosted zone by domain |
| 9 | `aws_caller_identity` | Gets the current AWS account ID and caller ARN |
| 10 | `aws_region` | Gets the current AWS region name |

## How to Use This Example

```bash
# 1. Initialize
terraform init

# 2. See what data would be fetched
terraform plan

# 3. Apply (no resources will be created — this is read-only!)
terraform apply

# 4. See the fetched values
terraform output
```

**⚠️ Important:** This configuration is **read-only** — it uses only `data` blocks and `output` blocks. Running `terraform apply` will **not** create any billable resources. It will:
- Query AWS APIs
- Store the results in your Terraform state
- Display them in the outputs

## Common Patterns

### Pattern 1: Dynamic AMI Selection
```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
}
```

### Pattern 2: Lookup Existing Network
```hcl
data "aws_vpc" "selected" {
  tags = {
    Environment = "production"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  tags = {
    Tier = "private"
  }
}
```

### Pattern 3: Cross-Account / Cross-Region Reference
```hcl
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

data "aws_vpc" "shared" {
  provider = aws.us_east_1
  default  = true
}
```

### Pattern 4: Multiple Filtering
```hcl
data "aws_ami" "custom" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["my-app-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
```

## Important Notes ⚠️

1. **Data sources are read every `plan` and `apply`.** Every time you run `terraform plan` or `terraform apply`, Terraform re-queries AWS. This means:
   - You always get fresh data
   - It's slightly slower (API calls are made)
   - If the queried resource is deleted externally, `plan`/`apply` will fail

2. **`count` and `for_each` with data sources.** You can use `count` or `for_each` on data sources too:
   ```hcl
   data "aws_subnet" "selected" {
     count = length(data.aws_subnets.all.ids)
     id    = data.aws_subnets.all.ids[count.index]
   }
   ```

3. **Data sources can depend on other data sources.** In this example folder, we look up the VPC first, then use its ID to find subnets and the route table.

4. **They respect provider configurations.** If you have a `provider` alias set up, a data source will use it — allowing you to query resources in other regions or accounts.

## When NOT to Use a Data Source

- ❌ To **create** infrastructure — use `resource` blocks
- ❌ To **store secrets** — outputs can expose them; use a secret store
- ❌ When the value is a simple static string — just use a `variable` with a `default`
- ❌ When you need to conditionally create a resource based on whether another exists — Terraform data sources fail the entire plan if the queried item doesn't exist. Use `try()` or `data.YOUR_TYPE.YOUR_NAME[*].id` with `count` for optional lookups

## Next Steps

- Combine data sources with **modules** to create reusable infrastructure
- Use `terraform_remote_state` data source to read outputs from other Terraform workspaces
- Look at the **Foundations** section for S3 backend and state locking examples
- Explore the **Projects** section for full end-to-end examples using data sources