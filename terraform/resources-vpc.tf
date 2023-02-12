locals {
  cidr   = "10.1.0.0/16"
  subnet = "10.1.0.0/24"
}

module "jenkins_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "Jenkins VPC"
  cidr = local.cidr

  enable_dns_hostnames = true

  azs                 = ["${var.region}a"]
  public_subnets      = [local.subnet]
  public_subnet_names = ["Jenkins subnet"]

  tags = local.tags
}
