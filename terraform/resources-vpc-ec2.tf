locals {
  cidr = "10.1.0.0/16"
  subnet = "10.1.0.0/24"
  controller_private_ip = "10.1.0.20"
  agent_private_ip = "10.1.0.30"

  tags = {
    Environment = var.environment
    Terraform = "true"
  }
}

module "jenkins_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "Jenkins VPC"
  cidr = local.cidr

  azs = ["${var.region}a"]
  public_subnets = [local.subnet]
  public_subnet_names = ["Jenkins subnet"]

  tags = local.tags
}

resource "aws_security_group" "jenkins_controller_sg" {
  name = "Jenkins controller security group"
  description = "Security group for Jenkins controller"
  vpc_id      = module.jenkins_vpc.vpc_id

  ingress {
    description = "My IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.my_ip]
  }

  # TODO: github webhook

  egress {
    description     = "All traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.tags
}

resource "aws_security_group" "jenkins_agent_sg" {
  name = "Jenkins agent security group"
  description = "Security group for Jenkins agent"
  vpc_id      = module.jenkins_vpc.vpc_id

  ingress {
    description = "My IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "SSH access from Jenkins controller"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.controller_private_ip}/32"]
  }

  egress {
    description     = "All traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.tags
}
