output "vpc_id" {
  value = aws_vpc.production-vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.production-vpc.cidr_block
}

output "public-subnet-1_id" {
  value = aws_subnet.public-subnet-1.id
}

output "public-subnet-2_id" {
  value = aws_subnet.public-subnet-2.id
}

output "public-subnet-3_id" {
  value = aws_subnet.public-subnet-3.id
}

output "private-subnet-1_id" {
  value = aws_subnet.private-subnet-1.id
}

output "private-subnet-2_id" {
  value = aws_subnet.private-subnet-2.id
}

output "private-subnet-3_id" {
  value = aws_subnet.private-subnet-3.id
}

