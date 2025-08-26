resource "aws_key_pair" "ec2-keypair" {
    key_name = "workshop-keypair"
    public_key = file("${path.module}/../keys/workshop-test-key.pub")
}

resource "aws_network_acl" "webapp-nacl" {
  vpc_id = aws_vpc.workshop-vpc.id

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "confluent-101-workshop-webapp-nacl-august-2025-${random_id.suffix.dec}"
  }
}

resource "aws_network_acl" "db-nacl" {
  vpc_id = aws_vpc.workshop-vpc.id

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "confluent-101-workshop-webapp-nacl-august-2025-${random_id.suffix.dec}"
  }
}

resource "aws_network_acl_association" "nacl-webapp-subnet-association" {
  network_acl_id = aws_network_acl.webapp-nacl.id
  subnet_id = aws_subnet.workshop-subnet.id
}

resource "aws_network_acl_association" "nacl-db-subnet-1-association" {
  network_acl_id = aws_network_acl.db-nacl.id
  subnet_id = aws_subnet.db-subnet-1.id
}

resource "aws_network_acl_association" "nacl-db-subnet-2-association" {
  network_acl_id = aws_network_acl.db-nacl.id
  subnet_id = aws_subnet.db-subnet-2.id
}

resource "aws_security_group" "webapp-sg" {
  name        = "webapp-sg-${random_id.suffix.dec}"
  description = "SG for the workshop webapp"
  vpc_id      = aws_vpc.workshop-vpc.id

  ingress {
    from_port = 0
    to_port= 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "webapp-sg-${random_id.suffix.dec}"
  }
}

resource "aws_security_group" "database-sg" {
  name        = "database-sg-${random_id.suffix.dec}"
  description = "SG for the workshop databases"
  vpc_id      = aws_vpc.workshop-vpc.id

  ingress {
    from_port = 0
    to_port= 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "database-sg-${random_id.suffix.dec}"
  }
}