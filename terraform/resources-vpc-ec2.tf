locals {
  cidr = "10.1.0.0/16"
  subnet = "10.1.0.0/24"
  controller_private_ip = "10.1.0.20"
  agent_private_ip = "10.1.0.30"

  tags = {
    Environment = var.environment
    Terraform = "true"
  }

  # https://api.github.com/meta
  github_webhook_ips = ["192.30.252.0/22", "185.199.108.0/22", "140.82.112.0/20", "143.55.64.0/20"]
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

  ingress {
    description = "GitHub webhook IPs"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = local.github_webhook_ips
  }

  egress {
    description     = "All traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.tags, {
    Name = "Jenkins controller security group"
  })
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

  tags = merge(local.tags, {
    Name = "Jenkins agent security group"
  })
}
