resource "aws_key_pair" "ec2-keypair" {
    key_name = "workshop-keypair"
    public_key = file("${path.module}/../keys/workshop-test-key.pub")
}