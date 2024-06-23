variable "aws-region" {
  default = "us-east-1"
}
variable "amis" {
  type = map(string)
  default = {
    us-east-1  = "ami-04b70fa74e45c3917"
    us-east-2  = "ami-04b70fa74e45c3917"
    ap-south-1 = "ami-04b70fa74e45c3917"
  }
}
variable "pub-key-path" {
  default = "keys/pub-terraformkey.pub"
}
variable "privat-key-path" {
  default = "keys/priv-terraformkey"
}
variable "instance-type" {
  default = "t2.micro"
}
variable "username" {
  default = "ubuntu"
}
variable "myip" {
  default = "183.83.39.125/32"
}
variable "rmquser" {
  default = "rabbit"
}
variable "rmqpass" {
  default = "Gr33n@pple123456"
}
variable "dbname" {
  default = "accounts"
}
variable "dbuser" {
  default = "admin"
}
variable "dbpass" {
  default = "admin123"
}
variable "instance-count" {
  default = "1"
}
variable "vpc-name" {
  default = "terraform-VPC"
}
variable "zones" {
  type = map(string)
  default = {
    zone1 = "us-east-1a"
    zone2 = "us-east-1b"
    zone3 = "us-east-1c"
  }
}
variable "VpcCIDR" {
  default = "10.0.0.0/16"
}

variable "pubSub" {
  type = map(string)
  default = {
    sub1 = "10.0.1.0/24"
    sub2 = "10.0.2.0/24"
    sub3 = "10.0.3.0/24"
  }
}
variable "privSub" {
  type = map(string)
  default = {
    sub1 = "10.0.4.0/24"
    sub2 = "10.0.5.0/24"
    sub3 = "10.0.6.0/24"
  }
}
