resource "aws_security_group" "ecs_security_group" {
  name        = "${var.ecs_cluster_name}-SG"
  description = "Security group for ECS Fargate tasks (no public SSH; uses AWS ECS Exec)"
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  ingress {
    description = "Allow ephemeral & application ports within VPC CIDR"
    from_port   = 32768
    protocol    = "tcp"
    to_port     = 65535
    cidr_blocks = [data.terraform_remote_state.infra.outputs.vpc_cidr_block]
  }

  egress {
    description = "Allow outbound HTTPS/dependencies traffic"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [var.internet_cidr_blocks]
  }

  tags = {
    Name = "${var.ecs_cluster_name}-SG"
  }
}

resource "aws_security_group" "ecs_alb_security_group" {
  name        = "${var.ecs_cluster_name}-ALB-SG"
  description = "Security group for Application Load Balancer (HTTP redirect + HTTPS TLS 1.3)"
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  ingress {
    description = "Allow HTTP for HTTPS 301 redirect"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = [var.internet_cidr_blocks]
  }

  ingress {
    description = "Allow HTTPS TLS 1.3 ingress traffic"
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = [var.internet_cidr_blocks]
  }

  egress {
    description = "Allow outbound traffic to ECS targets"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [var.internet_cidr_blocks]
  }

  tags = {
    Name = "${var.ecs_cluster_name}-ALB-SG"
  }
}
