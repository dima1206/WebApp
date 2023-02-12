locals {
  amazon_linux_ami = "ami-06c39ed6b42908a36"
}

resource "aws_key_pair" "my_ssh_pub_key" {
  key_name   = "my_ssh_pub_key"
  public_key = var.my_ssh_pub_key
}

resource "aws_instance" "jenkins_controller" {
  ami           = local.amazon_linux_ami
  instance_type = var.instance_type
  key_name      = "my_ssh_pub_key"

  vpc_security_group_ids = [aws_security_group.jenkins_controller_sg.id]
  subnet_id              = module.jenkins_vpc.public_subnets[0]

  tags = merge(local.tags, {
    Name = "Jenkins controller"
    Ansible_configure = "controller"
  })
}

resource "aws_instance" "jenkins_agent" {
  ami           = local.amazon_linux_ami
  instance_type = var.instance_type
  key_name      = "my_ssh_pub_key"

  vpc_security_group_ids = [aws_security_group.jenkins_agent_sg.id]
  subnet_id              = module.jenkins_vpc.public_subnets[0]

  tags = merge(local.tags, {
    Name = "Jenkins agent 1"
    Ansible_configure = "agent"
  })
}
