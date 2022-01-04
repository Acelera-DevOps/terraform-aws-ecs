## Provision

```shell 
$ terraform init -backend-config="infra-prod.config"
$ terraform plan -var-file="production.tfvars"
$ terraform apply -var-file="production.tfvars"
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.elastic-ip-for-nat-gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.production-igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat-gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.nat-gw-route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public-internet-gw-route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private-route-table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public-route-table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private-route-1-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private-route-2-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private-route-3-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public-subnet-1-route-table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public-subnet-2-route-table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public-subnet-3-route-table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private-subnet-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private-subnet-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private-subnet-3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public-subnet-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public-subnet-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public-subnet-3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.production-vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_subnet_1_cidr"></a> [private\_subnet\_1\_cidr](#input\_private\_subnet\_1\_cidr) | CIDR Block for Private Subnet 1 | `any` | n/a | yes |
| <a name="input_private_subnet_2_cidr"></a> [private\_subnet\_2\_cidr](#input\_private\_subnet\_2\_cidr) | CIDR Block for Private Subnet 2 | `any` | n/a | yes |
| <a name="input_private_subnet_3_cidr"></a> [private\_subnet\_3\_cidr](#input\_private\_subnet\_3\_cidr) | CIDR Block for Private Subnet 3 | `any` | n/a | yes |
| <a name="input_public_subnet-1-cidr"></a> [public\_subnet-1-cidr](#input\_public\_subnet-1-cidr) | Public Subnet 1 CIDR | `any` | n/a | yes |
| <a name="input_public_subnet-2-cidr"></a> [public\_subnet-2-cidr](#input\_public\_subnet-2-cidr) | Public Subnet 2 CIDR | `any` | n/a | yes |
| <a name="input_public_subnet-3-cidr"></a> [public\_subnet-3-cidr](#input\_public\_subnet-3-cidr) | Public Subnet 3 CIDR | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Aws Region | `string` | `"us-east-2"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR Block | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private-subnet-1_id"></a> [private-subnet-1\_id](#output\_private-subnet-1\_id) | n/a |
| <a name="output_private-subnet-2_id"></a> [private-subnet-2\_id](#output\_private-subnet-2\_id) | n/a |
| <a name="output_private-subnet-3_id"></a> [private-subnet-3\_id](#output\_private-subnet-3\_id) | n/a |
| <a name="output_public-subnet-1_id"></a> [public-subnet-1\_id](#output\_public-subnet-1\_id) | n/a |
| <a name="output_public-subnet-2_id"></a> [public-subnet-2\_id](#output\_public-subnet-2\_id) | n/a |
| <a name="output_public-subnet-3_id"></a> [public-subnet-3\_id](#output\_public-subnet-3\_id) | n/a |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->