
resource "aws_instance" "webapp-instance" {
    ami = var.WEBAPP_AMI
    instance_type = "t2.micro"
    subnet_id = aws_subnet.workshop-subnet.id
    # key_name = aws_key_pair.ec2-keypair.key_name    

    user_data = templatefile("${path.module}/templates/webapp.tpl", {
        RDS1_VARS = local.RDS1_VARS
        RDS2_VARS = local.RDS2_VARS
    })


    tags = {
      Name = "webapp-instance-${random_id.suffix.dec}"
    }

    vpc_security_group_ids = [aws_security_group.webapp-sg.id]

    depends_on = [aws_internet_gateway.igw, aws_db_instance.RDS1-src, aws_db_instance.RDS2-dst]
}

resource "aws_db_instance" "RDS1-src" {
  allocated_storage    = 10
  db_name              = local.DB_DEFAULT_NAME
  engine               = "postgres"
  engine_version       = "15.8"
  instance_class       = "db.t4g.micro"
  username             = local.DB_USER
  password             = local.DB_PASSWORD
  multi_az = false

  identifier = "rds1-src-${random_id.suffix.dec}"

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
  name        = "rds-logical-pg-${random_id.suffix.dec}"
  family      = "postgres15"
  description = "Parameter group for logical replication"

  parameter {
    name         = "rds.logical_replication"
    value        = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_wal_senders"
    value        = "20"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_replication_slots"
    value        = "20"
    apply_method = "pending-reboot"
  }
}