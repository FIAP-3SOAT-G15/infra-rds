resource "aws_db_instance" "default" {
  allocated_storage           = 10
  db_name                     = "selfordermanagement"
  identifier                  = "selfordermanagement"
  engine                      = "postgres"
  engine_version              = "15.6"
  instance_class              = "db.t2.micro"
  parameter_group_name        = "default.postgres15"

  username                    = "master"
  manage_master_user_password = true

  multi_az                    = false
  backup_retention_period     = 0
  skip_final_snapshot         = true
}
