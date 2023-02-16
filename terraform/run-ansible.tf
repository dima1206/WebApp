resource "null_resource" "ansible_playbook" {
  provisioner "local-exec" {
    working_dir = "../ansible"
    command = "ansible-playbook -i aws_ec2.yml --private-key ${var.my_ssh_private_key_path} -u ec2-user --vault-password-file ${var.ansible_vault_password_path} controller-playbook.yml"
  }
  # controller interracts with agents during the play
  depends_on = [aws_instance.jenkins_controller, aws_instance.jenkins_agent1, aws_instance.webserver]
}
