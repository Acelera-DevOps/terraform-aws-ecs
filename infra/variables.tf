variable "region" {
    default = "us-east-2"
    description = "Aws Region"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "VPC CIDR Block"
}

variable "public_subnet-1-cidr" {
  description = "Public Subnet 1 CIDR"
}

variable "public_subnet-2-cidr" {
  description = "Public Subnet 2 CIDR"

}
variable "public_subnet-3-cidr" {
  description = "Public Subnet 3 CIDR"
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
}

variable "private_subnet_2_cidr" {
  description = "CIDR Block for Private Subnet 2"
}

variable "private_subnet_3_cidr" {
  description = "CIDR Block for Private Subnet 3"
}