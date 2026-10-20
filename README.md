# AWS ECS Fargate 3-Layer Reference Architecture (Terraform + Spring Boot 3)

[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.6.0-7B42BC?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS Provider](https://img.shields.io/badge/AWS_Provider-~%3E5.0-FF9900?logo=amazonaws&logoColor=white)](https://registry.terraform.io/providers/hashicorp/aws/latest)
[![Java](https://img.shields.io/badge/Java-21_LTS-ED8B00?logo=openjdk&logoColor=white)](https://adoptium.net/)
[![Spring Boot](https://img.shields.io/badge/Spring_Boot-3.3.5-6DB33F?logo=springboot&logoColor=white)](https://spring.io/projects/spring-boot)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](./LICENSE)

Production-grade **3-Layer Infrastructure-as-Code (IaC)** architecture for running containerized **Spring Boot 3 (Java 21 LTS)** microservices on **AWS ECS Fargate**, featuring state isolation via S3 Remote State, TLS 1.3 Application Load Balancing, automated Route53 + ACM DNS validation, Principle of Least Privilege (PoLP) IAM roles, and Target Tracking Auto Scaling.

---

## Architecture Overview

The repository decouples infrastructure lifecycle into three independent Terraform state layers (`infra` -> `platform` -> `application`) linked via `terraform_remote_state`:

```mermaid
flowchart TB
    subgraph L1["Layer 1: Network Foundation (infra/)"]
        VPC["AWS VPC (10.0.0.0/16)<br/>DNS Support & Hostnames"]
        IGW["Internet Gateway"]
        NAT["NAT Gateway + EIP"]
        PUB["Public Subnets (3 AZs)<br/>10.0.1.0/24 | 10.0.2.0/24 | 10.0.3.0/24"]
        PRIV["Private Subnets (3 AZs)<br/>10.0.4.0/24 | 10.0.5.0/24 | 10.0.6.0/24"]
        IGW --> PUB --> NAT --> PRIV
    end

    subgraph L2["Layer 2: Shared Container Platform (platform/)"]
        R53["Route53 Hosted Zone<br/>(*.eriktonon.com)"]
        ACM["ACM Wildcard Certificate<br/>(DNS Validated)"]
        ALB["Application Load Balancer<br/>HTTP:80 -> HTTPS:443 (TLS 1.3)"]
        ECS["ECS Fargate Cluster<br/>(Container Insights Enabled)"]
        R53 --> ALB
        ACM -.-> ALB
    end

    subgraph L3["Layer 3: Application Workload (application/)"]
        TG["ALB Target Group (IP Mode)<br/>Health Check: /actuator/health"]
        SVC["ECS Fargate Service<br/>(Spring Boot 3.3 / Java 21)"]
        AS["Application Auto Scaling<br/>(CPU Target Tracking @ 70%)"]
        CW["CloudWatch Log Group<br/>(30-Day Retention)"]
        IAM["Dedicated Execution & Task<br/>PoLP IAM Roles"]
        ALB -->|Host Header Rule| TG --> SVC
        AS -.->|Scales 2..6 Tasks| SVC
        SVC --> CW
        IAM -.-> SVC
    end

    L1 ==>|terraform_remote_state.infra| L2
    L2 ==>|terraform_remote_state.platform| L3
```

---

## Key Security & Reliability Highlights

- **3-Tier State Isolation**: Network changes (`infra/`), cluster/ALB governance (`platform/`), and microservice deployments (`application/infrastructure/`) maintain isolated S3 state files (`PROD/infra.tfstate`, `PROD/platform.tfstate`, `PROD/springbootapp.tfstate`) to minimize blast radius.
- **Zero-Trust Network & TLS 1.3**:
  - ALB enforces **`ELBSecurityPolicy-TLS13-1-2-2021-06`** on port `443` with automatic `HTTP_301` redirect from port `80` and `drop_invalid_header_fields = true`.
  - No public SSH (`port 22`) exposed on ECS Security Groups; interactive debugging relies on **AWS ECS Exec** (`enable_execute_command = true`) over AWS Systems Manager Session Manager.
- **Principle of Least Privilege (PoLP) IAM**:
  - Strictly separates the **ECS Task Execution Role** (`AmazonECSTaskExecutionRolePolicy` for pulling ECR images and emitting startup logs) from the **Application Task Role** (scoped exclusively to its CloudWatch Log Group and SSM Session Manager channels).
- **Hardened Container Runtime**:
  - Multi-stage `Dockerfile` using `eclipse-temurin:21-jdk-alpine` for compilation and `eclipse-temurin:21-jre-alpine` for runtime.
  - Executes as an unprivileged user (`appuser:appgroup`, UID `10001`), configured with container-aware JVM flags (`-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0`) and native `HEALTHCHECK` against `/actuator/health`.

---

## Repository Structure

```text
terraform-aws-ecs/
├── .github/workflows/
│   └── ci.yml                        # Automated Terraform fmt & validate pipeline
├── infra/                            # Layer 1: Multi-AZ VPC, Subnets, IGW & NAT Gateway
│   ├── development.tfvars
│   ├── infra-prod.config
│   ├── outputs.tf
│   ├── production.tfvars
│   ├── variables.tf
│   ├── versions.tf
│   ├── vpc.tf
│   └── README.md
├── platform/                         # Layer 2: ECS Fargate Cluster, ALB (TLS 1.3), ACM & Route53
│   ├── domain.tf
│   ├── ecs.tf
│   ├── outputs.tf
│   ├── platform-prod.config
│   ├── production.tfvars
│   ├── security-groups.tf
│   ├── variables.tf
│   ├── versions.tf
│   └── README.md
└── application/                      # Layer 3: Spring Boot 3.3 (Java 21) App & ECS Service IaC
    ├── infrastructure/
    │   ├── app-prod.config
    │   ├── app.tf
    │   ├── deploy.sh
    │   ├── Dockerfile
    │   ├── production.tfvars
    │   ├── task_definition.json
    │   ├── variables.tf
    │   └── versions.tf
    ├── src/
    └── pom.xml
```

---

## Step-by-Step Provisioning Guide

### Prerequisites

- **Terraform** `>= 1.6.0`
- **AWS CLI** v2 configured with appropriate credentials
- **Java 21** & **Docker** (for building the application image)
- An existing S3 bucket for Terraform remote state

### 1. Provision Layer 1 — Network Foundation (`infra/`)

```bash
cd infra
terraform init -backend-config="infra-prod.config"
terraform plan -var-file="production.tfvars"
terraform apply -var-file="production.tfvars"
```

### 2. Provision Layer 2 — ECS Cluster & ALB (`platform/`)

```bash
cd ../platform
terraform init -backend-config="platform-prod.config"
terraform plan -var-file="production.tfvars"
terraform apply -var-file="production.tfvars"
```

### 3. Build, Push & Deploy Layer 3 — Application (`application/`)

```bash
cd ../application/infrastructure
export AWS_ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
export SERVICE_TAG="1.0.0"

sh deploy.sh build
sh deploy.sh dockerize
sh deploy.sh plan
sh deploy.sh deploy
```

---

## Author

**Erik Tonon** — Cloud & Platform Architect / SRE  
Website: [eriktonon.com](https://eriktonon.com)
