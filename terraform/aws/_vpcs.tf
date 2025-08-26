resource "aws_vpc" "workshop-vpc" {
    cidr_block = "10.0.0.0/24"

    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = "confluent-101-workshop-vpc-august-2025-${random_id.suffix.dec}"
    }
}


resource "aws_subnet" "workshop-subnet" {
    vpc_id = aws_vpc.workshop-vpc.id
    cidr_block = "10.0.0.0/25"
    map_public_ip_on_launch = true

    tags = {
        Name = "workshop-subnet-${random_id.suffix.dec}"
    }


}

resource "aws_subnet" "db-subnet-1" {
    vpc_id = aws_vpc.workshop-vpc.id
    cidr_block = "10.0.0.128/26"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-1a"

    tags = {
        Name = "db-subnet-1-${random_id.suffix.dec}"
    }


}

resource "aws_subnet" "db-subnet-2" {
    vpc_id = aws_vpc.workshop-vpc.id
    cidr_block = "10.0.0.192/26"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-1b"

    tags = {
        Name = "db-subnet-2-${random_id.suffix.dec}"
    }


}

resource "aws_route_table" "workshop-route-table" {

    vpc_id = aws_vpc.workshop-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    route {
        cidr_block = "10.0.0.0/24"
        gateway_id = "local"
    }

    tags = {
        Name = "workshop-route-table-${random_id.suffix.dec}"
    }
}

resource "aws_route_table_association" "workshop-route-table-association" {
    subnet_id = aws_subnet.workshop-subnet.id
    route_table_id = aws_route_table.workshop-route-table.id
}

resource "aws_route_table_association" "db-1-route-table-association" {
    subnet_id = aws_subnet.db-subnet-1.id
    route_table_id = aws_route_table.workshop-route-table.id
}

resource "aws_route_table_association" "db-2-route-table-association" {
    subnet_id = aws_subnet.db-subnet-2.id
    route_table_id = aws_route_table.workshop-route-table.id
}


resource "aws_db_subnet_group" "workshop-db-subnet-group" {
    name = "workshop-db-subnet-group"
    description = "subnet group for rds instances in workshop"
    subnet_ids = [
        aws_subnet.db-subnet-1.id,
        aws_subnet.db-subnet-2.id
    ]

    tags = {
        Name = "workshop-db-subnet-group-${random_id.suffix.dec}"
    }
}

resource "aws_internet_gateway" "igw" {

  tags = {
    Name = "workshop-internet-gateway-${random_id.suffix.dec}"
  }

  depends_on = [aws_vpc.workshop-vpc]
}

resource "aws_internet_gateway_attachment" "igw_attach" {
  vpc_id              = aws_vpc.workshop-vpc.id
  internet_gateway_id = aws_internet_gateway.igw.id
}