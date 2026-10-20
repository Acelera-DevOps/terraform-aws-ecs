# remote state
remote_state_key    = "PROD/infra.tfstate"
remote_state_bucket = "terraform-ecs-production-ek-temp"

ecs_domain_name      = "eriktonon.com"
ecs_cluster_name     = "Production-ECS-Cluster"
internet_cidr_blocks = "0.0.0.0/0"
