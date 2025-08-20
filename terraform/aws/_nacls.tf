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
    Name = "confluent-101-workshop-webapp-nacl-august-2025"
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
    Name = "confluent-101-workshop-webapp-nacl-august-2025"
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