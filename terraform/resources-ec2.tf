locals {
  amazon_linux_ami = "ami-06c39ed6b42908a36"

  agent1_private_ip    = "10.1.0.10"
  webserver_private_ip = "10.1.0.20"
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

resource "aws_instance" "jenkins_agent1" {
  ami           = local.amazon_linux_ami
  instance_type = var.instance_type
  key_name      = "my_ssh_pub_key"
  private_ip    = local.agent1_private_ip

  vpc_security_group_ids = [aws_security_group.jenkins_agent_sg.id]
  subnet_id              = module.jenkins_vpc.public_subnets[0]

  user_data = "${file("userdata/agent.sh")}"

  tags = merge(local.tags, {
    Name = "Jenkins agent 1"
  })
}

resource "aws_instance" "webserver" {
  ami           = local.amazon_linux_ami
  instance_type = var.instance_type
  key_name      = "my_ssh_pub_key"
  private_ip    = local.webserver_private_ip

  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  subnet_id              = module.jenkins_vpc.public_subnets[0]

  user_data = "${file("userdata/webserver.sh")}"

  tags = merge(local.tags, {
    Name = "Webserver"
  })
}
