resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "selfordermanagement"
  engine               = "postgres"
  engine_version       = "16.0"
  instance_class       = "db.t3.micro"
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true
  username             = "admin"
  password             = data.aws_secretsmanager_secret_version.password
}

resource "random_password" "master" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "password" {
  name = "self-order-management-db-password"
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id     = aws_secretsmanager_secret.password.id
  secret_string = random_password.master.result
}

data "aws_secretsmanager_secret" "password" {
  name = "self-order-management-db-password"
}

data "aws_secretsmanager_secret_version" "password" {
  secret_id = data.aws_secretsmanager_secret.password
}
