resource "aws_key_pair" "keypair" {
  key_name   = "keypair"
  public_key = file(var.pub-key-path)
}