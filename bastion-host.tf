resource "aws_instance" "bastion" {
  ami                    = lookup(var.amis, var.aws-region)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.keypair.key_name
  subnet_id              = module.vpc.public_subnets.0
  count                  = var.instance-count
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  tags = {
    Name    = "vprofile-bastion"
    PROJECT = "vprofile"
  }

  provisioner "file" {
    content     = templatefile("db-deploy.tmpl", { rds-endpoint = aws_db_instance.rds.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/vprofile-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y mysql-client",
      "chmod +x /tmp/vprofile-dbdeploy.sh",
      "sudo /tmp/vprofile-debdeploy.sh"
    ]
  }

  connection {
    user        = var.username
    private_key = file(var.privat-key-path)
    host        = self.public_ip
  }

  depends_on = [aws_db_instance.rds]

}