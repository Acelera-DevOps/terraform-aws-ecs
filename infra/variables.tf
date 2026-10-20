variable "region" {
  type        = string
  default     = "us-east-2"
  description = "AWS Region"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC CIDR Block"
}

variable "public_subnet-1-cidr" {
  type        = string
  description = "Public Subnet 1 CIDR"
}

variable "public_subnet-2-cidr" {
  type        = string
  description = "Public Subnet 2 CIDR"
}

variable "public_subnet-3-cidr" {
  type        = string
  description = "Public Subnet 3 CIDR"
}

variable "private_subnet_1_cidr" {
  type        = string
  description = "CIDR Block for Private Subnet 1"
}

variable "private_subnet_2_cidr" {
  type        = string
  description = "CIDR Block for Private Subnet 2"
}

variable "private_subnet_3_cidr" {
  type        = string
  description = "CIDR Block for Private Subnet 3"
}
