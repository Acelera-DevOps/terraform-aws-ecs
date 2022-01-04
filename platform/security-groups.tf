resource "aws_security_group" "ecs_alb_security_group" {
  name = "${var.ecs_cluster_name}-ALB"
  description = "Security Group for ALB traffic for ECS cluster"
  vpc_id = data.terraform_remote_state.infra.outputs.vpc_id

  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = var.internet_cidr_blocks
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = var.internet_cidr_blocks

  }
}