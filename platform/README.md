# Layer 2 — ECS Fargate Platform (`platform/`)

Provisions the shared AWS ECS Fargate cluster with CloudWatch Container Insights enabled, an Application Load Balancer (ALB) enforcing TLS 1.3 (`ELBSecurityPolicy-TLS13-1-2-2021-06`) and HTTP-to-HTTPS `301` redirect, automated ACM wildcard DNS certificate validation via Route53, hardened Security Groups (zero public SSH), and Least-Privilege (PoLP) IAM roles.

## Provisioning

```bash
terraform init -backend-config="platform-prod.config"
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
| `remote_state_bucket` | S3 bucket storing Layer 1 (`infra`) remote state | `string` | n/a | yes |
| `remote_state_key` | S3 key for Layer 1 (`infra`) state file | `string` | n/a | yes |
| `ecs_cluster_name` | Name prefix for ECS Cluster and ALB resources | `string` | n/a | yes |
| `ecs_domain_name` | Root Route53 domain name (e.g., `eriktonon.com`) | `string` | n/a | yes |
| `internet_cidr_blocks` | Allowed ingress CIDR block for ALB | `string` | `"0.0.0.0/0"` | yes |

## Outputs

| Name | Description |
|------|-------------|
| `vpc_id` | VPC ID inherited from Layer 1 (`infra`) |
| `vpc_cidr_block` | VPC CIDR block inherited from Layer 1 (`infra`) |
| `ecs_alb_listener_arn` | HTTPS (443) ALB Listener ARN for host-header routing rules |
| `ecs_cluster_name` | ECS Fargate Cluster name |
| `ecs_cluster_role_name` | ECS Cluster IAM role name |
| `ecs_cluster_role_arn` | ECS Cluster IAM role ARN |
| `ecs_domain_name` | Configured Route53 domain name |
| `ecs_public_subnets` | Public Subnet IDs |
| `ecs_private_subnets` | Private Subnet IDs |
