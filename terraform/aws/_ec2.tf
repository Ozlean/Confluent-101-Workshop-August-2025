
resource "aws_instance" "webapp-instance" {
    ami = local.WEBAPP_AMI
    instance_type = "t2.micro"
    subnet_id = aws_subnet.workshop-subnet.id
    key_name = aws_key_pair.ec2-keypair.key_name    

    user_data = templatefile("${path.module}/userdata-templates/webapp.tpl", {
        RDS1_VARS = local.RDS1_VARS
        RDS2_VARS = local.RDS2_VARS
    })


    tags = {
        Name = "webapp-instance"
    }

    vpc_security_group_ids = [aws_security_group.webapp-sg.id]

    depends_on = [aws_internet_gateway.igw, aws_db_instance.RDS1-src, aws_db_instance.RDS2-dst]
}