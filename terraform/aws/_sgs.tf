resource "aws_security_group" "webapp-sg" {
  name        = "webapp-sg"
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
    Name = "webapp-sg"
  }
}

resource "aws_security_group" "database-sg" {
  name        = "database-sg"
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
    Name = "database-sg"
  }
}