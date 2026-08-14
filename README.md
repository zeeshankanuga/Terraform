# Terraform Projects 🚀

A curated collection of Terraform configurations for AWS — organized by concept, from **foundations** to **full infrastructure projects**. Each folder is a standalone Terraform example you can run to learn a specific skill.

## Directory Structure

```
Terraform/
├── 01-Foundations/          # Core setup: providers, backends, state locking
├── 02-Networking/           # VPCs, subnets, routing, load balancers
├── 03-Compute/              # EC2 instances, provisioners
├── 04-Modules/              # Reusable module patterns
├── 05-Advanced/             # Workspaces, imports, data sources
├── 06-Projects/             # End-to-end infrastructure projects
└── README.md                # ← You are here
```

---

## 📘 01 — Foundations

| Project | What you'll learn |
|---|---|
| **[s3-backend-state-locking](01-Foundations/s3-backend-state-locking/)** | S3 backend for remote state + DynamoDB state locking |

## 🌐 02 — Networking

| Project | What you'll learn |
|---|---|
| **[custom-vpc-with-load-balancer](02-Networking/custom-vpc-with-load-balancer/)** | VPC, public/private subnets, route tables, IGW, NAT, Application Load Balancer |

## 🖥️ 03 — Compute

| Project | What you'll learn |
|---|---|
| **[remote-exec-provisioner](03-Compute/remote-exec-provisioner/)** | EC2 with `file` and `remote-exec` provisioners, plus a demo Flask app |

## 🧩 04 — Modules

| Project | What you'll learn |
|---|---|
| **[modular-ec2](04-Modules/modular-ec2/)** | Basic module structure — EC2 instance wrapped in a reusable module |
| **[reusable-modules](04-Modules/reusable-modules/)** | Standalone modules for EC2, S3, KMS, and Security Groups |

## 🚀 05 — Advanced

| Project | What you'll learn |
|---|---|
| **[workspaces](05-Advanced/workspaces/)** | Terraform workspaces for multi-environment (dev/staging/prod) deployments |
| **[import-existing-resources](05-Advanced/import-existing-resources/)** | Import existing AWS resources into Terraform management |
| **[data-sources](05-Advanced/data-sources/)** | ★ **Data sources deep-dive** — query existing infra, AMI lookups, IAM policies, and more |

## 🏗️ 06 — Complete Projects

| Project | What you'll learn |
|---|---|
| **[complete-vpc-infrastructure](06-Projects/complete-vpc-infrastructure/)** | Full VPC with public/private subnets, NAT, VPC peering, EC2, SG, and null resources |
| **[modular-infrastructure-backend](06-Projects/modular-infrastructure-backend/)** | Root module calling sub-modules with S3 backend and DynamoDB locking |

---

## Quick Start

```bash
# Choose a project
cd 01-Foundations/s3-backend-state-locking

# Initialize Terraform
terraform init

# Preview what will be created
terraform plan

# Apply the configuration
terraform apply
```

> **💡 Tip:** Start with **[01-Foundations](01-Foundations/s3-backend-state-locking/)** to understand state and backends, then progress upwards through the sections.

## Key Terraform Concepts Covered

| Concept | Where to find it |
|---|---|
| **Provider configuration** | Every project — `provider.tf` |
| **S3 Remote State + Locking** | `01-Foundations/s3-backend-state-locking/` |
| **Variables & Outputs** | Every project — `variables.tf` / `outputs.tf` |
| **Data Sources** | `05-Advanced/data-sources/`, `06-Projects/complete-vpc-infrastructure/data.tf` |
| **Modules (input/output)** | `04-Modules/modular-ec2/` |
| **Workspaces** | `05-Advanced/workspaces/` |
| **Resource Import** | `05-Advanced/import-existing-resources/` |
| **Provisioners** | `03-Compute/remote-exec-provisioner/` |
| **VPC + Subnets + Routing** | `02-Networking/custom-vpc-with-load-balancer/` |
| **VPC Peering** | `06-Projects/complete-vpc-infrastructure/8.vpc-peering.tf` |
| **Load Balancers (ALB)** | `02-Networking/custom-vpc-with-load-balancer/` |
| **IAM Policies** | `05-Advanced/data-sources/` (data.aws_iam_policy_document) |
| **Security Groups** | `04-Modules/reusable-modules/sg.tf` |

## How to Use This Repository

### For Learning
- Follow the **numbered sections** in order — each builds on concepts from the previous
- Start with **01-Foundations** → then **02-Networking** → **03-Compute** → **04-Modules** → **05-Advanced**
- Reference **06-Projects** to see how everything fits together

### For Reference
- Need an S3 backend setup? → `01-Foundations/s3-backend-state-locking/`
- Need an ALB example? → `02-Networking/custom-vpc-with-load-balancer/`
- Need a module template? → `04-Modules/modular-ec2/`
- Need data source examples? → `05-Advanced/data-sources/`

### For Production
- The **06-Projects** section contains production-adjacent patterns
- Combine the **reusable-modules** (`04-Modules/reusable-modules/`) with your own project structure
- Always use **remote state + locking** for team environments

---

## About the Author

🌟 Happy Coding! 🌟


---

## 👩‍💻 Author

**Zeeshan kanuga** — Technical Architect |DevOps Engineer | Platform Engineering | AI-Augmented DevOps

Built by [Zeeshan Kanuga](https://github.com/zeeshankanuga)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/zeeshankanuga/)
=======
This repository was built and maintained by **Zeeshan Kanuga** as a hands-on collection of Terraform patterns for DevOps engineers. It covers real-world AWS infrastructure scenarios with clean, reusable code.


**Happy Terraforming!** 🏗️
