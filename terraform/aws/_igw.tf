resource "aws_internet_gateway" "igw" {

  tags = {
    Name = "workshop-internet-gateway"
  }

  depends_on = [aws_vpc.workshop-vpc]
}

resource "aws_internet_gateway_attachment" "igw_attach" {
  vpc_id              = aws_vpc.workshop-vpc.id
  internet_gateway_id = aws_internet_gateway.igw.id
}