# Layer 1 — Network Infrastructure (`infra/`)

Provisions the foundational Multi-AZ AWS Virtual Private Cloud (VPC) network topology across 3 Availability Zones (`a`, `b`, `c`), including public and private subnets, route tables, Internet Gateway, and NAT Gateway.

## Provisioning

```bash
terraform init -backend-config="infra-prod.config"
terraform plan -var-file="production.tfvars"
terraform apply -var-file="production.tfvars"
```

## Requirements

| Name | Version |
|------|---------|
| terraform | `>= 1.6.0` |
| aws | `~> 5.0` |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `region` | AWS Region | `string` | `"us-east-2"` | no |
| `vpc_cidr` | VPC CIDR Block | `string` | `"10.0.0.0/16"` | no |
| `public_subnet-1-cidr` | Public Subnet 1 CIDR (AZ a) | `string` | n/a | yes |
| `public_subnet-2-cidr` | Public Subnet 2 CIDR (AZ b) | `string` | n/a | yes |
| `public_subnet-3-cidr` | Public Subnet 3 CIDR (AZ c) | `string` | n/a | yes |
| `private_subnet_1_cidr` | Private Subnet 1 CIDR (AZ a) | `string` | n/a | yes |
| `private_subnet_2_cidr` | Private Subnet 2 CIDR (AZ b) | `string` | n/a | yes |
| `private_subnet_3_cidr` | Private Subnet 3 CIDR (AZ c) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| `vpc_id` | ID of the provisioned Production VPC |
| `vpc_cidr_block` | CIDR block of the Production VPC |
| `public_subnets` | List of Public Subnet IDs across 3 AZs |
| `private_subnets` | List of Private Subnet IDs across 3 AZs |
| `public-subnet-1_id` | Public Subnet 1 ID |
| `public-subnet-2_id` | Public Subnet 2 ID |
| `public-subnet-3_id` | Public Subnet 3 ID |
| `private-subnet-1_id` | Private Subnet 1 ID |
| `private-subnet-2_id` | Private Subnet 2 ID |
| `private-subnet-3_id` | Private Subnet 3 ID |
