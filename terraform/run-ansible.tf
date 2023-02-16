resource "null_resource" "ansible_playbook" {
  provisioner "local-exec" {
    working_dir = "../ansible"
    command = "ansible-playbook -i aws_ec2.yml --private-key ${var.my_ssh_private_key_path} -u ec2-user --vault-password-file ${var.ansible_vault_password_path} controller-playbook.yml"
  }

  # controller interracts with agents during the play
  triggers = {
    controller_arn = aws_instance.jenkins_controller.arn
    agent1_arn = aws_instance.jenkins_agent1.arn
    webserver_arn = aws_instance.webserver.arn
  }
}
