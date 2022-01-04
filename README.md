### Terraform ECS-Fargate

## How to provision
```bash
# Step 1
$ git clone https://github.com/Acelera-DevOps/terraform-aws-ecs
$ cd terraform-aws-ecs
$ cd infra
$ terraform init -backend-config="infra-prod.config"
$ terraform plan -var-file="production.tfvars"
$ terraform apply -var-file="production.tfvars"
# Step 2
$ cd ..
$ cd platform
$ terraform init -backend-config="platform-prod.config"
$ terraform plan -var-file="production.tfvars"
$ terraform apply -var-file="production.tfvars"

# Step 3 in progress
```

## Repository Structure

```
terraform-aws-ecs/
|-- infra/
|   |-- vpc.tf
|   |-- infra-prod.config
|   |-- outputs.tf
|   |-- production.tfvars
|   |-- variables.tf
|   |-- versions.tf
|   `-- readme.md
|-- plataform/
|   |-- outputs.tf
|   |-- platform-prod.config
|   |-- production.tfvars
|   |-- variables.tf
|   |-- versions.tf
|   |-- security-groups.tf
|   |-- ecs.tf
|   |-- domain.tf
|   `-- readme.md
`-- application/
    |-- infrastructure/
    |   |-- outputs.tf
    |   |-- platform-prod.config
    |   |-- production.tfvars
    |   |-- variables.tf
    |   |-- versions.tf
    |   |-- task_definition.json
    |   |-- Dockerfile
    |   |-- deploy.sh
    |   `-- app.tf
    `-- src/
        `-- javafiles
```


## Project in progress...