resource "aws_security_group" "bean-elb-sg" {
  name   = "bean-elb-sg"
  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Security group for bastion ec2 instance"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "prod-sg" {
  name        = "prod-sg"
  description = "Security group fro beanstalk instances"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  //allows traffic on port 22 only htat are part of bastion-sg
  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.bastion-sg.id]
  }

}

resource "aws_security_group" "backend-sg" {
  name        = "backend-sg"
  description = "Secuirty group fro RDS, active mq, elsatic cache"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  //allows any traffic that is apart of the prod-sg
  ingress {
    from_port       = 0
    protocol        = "-1"
    to_port         = 0
    security_groups = [aws_security_group.prod-sg.id]
  }
  //allows traffic on 3306 if part of the bastion-sg
  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [aws_security_group.bastion-sg.id]
  }
}
//allow resources in same security group to communicate with eachother
resource "aws_security_group_rule" "sg-allow-itself" {
  from_port                = 0
  protocol                 = "tcp"
  to_port                  = 65535
  type                     = "ingress"
  security_group_id        = aws_security_group.backend-sg.id
  source_security_group_id = aws_security_group.backend-sg.id
}