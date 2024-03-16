locals {
  name     = "selfordermanagementdb"
  username = "master"
  port     = 5432
}

data "terraform_remote_state" "tech-challenge" {
  backend = "s3"

  config = {
    bucket = "fiap-3soat-g15-infra-tech-challenge-state"
    key    = "live/terraform.tfstate"
    region = var.region
  }
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.5.2"

  identifier = local.name

  engine               = "postgres"
  engine_version       = "15"
  family               = "postgres15"
  major_engine_version = "15"
  instance_class       = "db.t3.micro"

  allocated_storage     = 10
  max_allocated_storage = 20

  storage_encrypted = false

  db_name  = local.name
  username = local.username
  port     = local.port

  manage_master_user_password = true

  multi_az               = false
  db_subnet_group_name   = data.terraform_remote_state.tech-challenge.outputs.database_subnet_group_name
  vpc_security_group_ids = [module.security_group.security_group_id]

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name   = local.name
  vpc_id = data.terraform_remote_state.tech-challenge.outputs.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = data.terraform_remote_state.tech-challenge.outputs.vpc_cidr_block
    },
  ]
}

module "ssm_parameters" {
  source = "terraform-aws-modules/ssm-parameter/aws"
  name   = "/live/selfordermanagement/db"
  type   = "String"
  value = jsonencode({
    name : local.name,
    endpoint : module.db.db_instance_endpoint,
    port : local.port
  })
}
