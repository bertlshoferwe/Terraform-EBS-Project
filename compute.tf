resource "aws_instance" "demo" {
  ami           = var.amis["us-east-1"]
  instance_type = var.instance-type

  tags = {
    name = "demo_ec2"
  }
}