module "vpc" {
  //where the terraform module is loacted    
  source = "terraform-aws-modules/vpc/aws"
  //VPC creation information
  name = var.vpc-name
  cidr = var.VpcCIDR
  //create AZ's, private, and public subnets
  azs             = [var.zones.zone1, var.zones.zone2, var.zones.zone3]
  private_subnets = [var.privSub.sub1, var.privSub.sub2, var.privSub.sub3]
  public_subnets  = [var.pubSub.sub1, var.pubSub.sub2, var.pubSub.sub3]
  //enable nat gatway
  enable_nat_gateway = true
  single_nat_gateway = true
  //enable dns suppport
  enable_dns_hostnames = true
  enable_dns_support   = true
  //tags to be applied to all resouces created by this module
  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}