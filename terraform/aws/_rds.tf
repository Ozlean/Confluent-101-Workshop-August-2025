resource "aws_db_instance" "RDS1-src" {
  allocated_storage    = 10
  db_name              = local.DB_DEFAULT_NAME
  engine               = "postgres"
  engine_version       = "15.8"
  instance_class       = "db.t4g.micro"
  username             = local.DB_USER
  password             = local.DB_PASSWORD
  multi_az = false

  identifier = "rds1-src"

  db_subnet_group_name = aws_db_subnet_group.workshop-db-subnet-group.name
  vpc_security_group_ids = [aws_security_group.database-sg.id]
  parameter_group_name = aws_db_parameter_group.rds_logical_pg.name

  skip_final_snapshot  = true
  publicly_accessible = true



}

resource "aws_db_instance" "RDS2-dst" {
  allocated_storage    = 10
  db_name              = local.DB_DEFAULT_NAME
  engine               = "postgres"
  engine_version       = "15.8"
  instance_class       = "db.t4g.micro"
  username             = local.DB_USER
  password             = local.DB_PASSWORD
  multi_az = false

  identifier = "rds2-dst"

  db_subnet_group_name = aws_db_subnet_group.workshop-db-subnet-group.name
  vpc_security_group_ids = [aws_security_group.database-sg.id]
  parameter_group_name = aws_db_parameter_group.rds_logical_pg.name

  skip_final_snapshot  = true
  publicly_accessible = true

}


resource "aws_db_parameter_group" "rds_logical_pg" {
  name        = "rds-logical-pg"
  family      = "postgres15"
  description = "Parameter group for logical replication"

  parameter {
    name         = "rds.logical_replication"
    value        = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_wal_senders"
    value        = "5"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_replication_slots"
    value        = "5"
    apply_method = "pending-reboot"
  }
}