output "jenkins_controller_pub_ip" {
  value       = aws_instance.jenkins_controller.public_ip
  description = "Public IP for Jenkins controller"
}

output "jenkins_agent1_pub_ip" {
  value       = aws_instance.jenkins_agent1.public_ip
  description = "Public IP for Jenkins agent 1"
}

output "websrver_pub_ip" {
  value       = aws_instance.webserver.public_ip
  description = "Public IP for Webserver"
}

output "jenkins_controller_url" {
  value       = "http://${aws_instance.jenkins_controller.public_dns}:8080"
  description = "Jenkins controller URL"
}

output "webserver_url" {
  value       = "http://${aws_instance.webserver.public_dns}"
  description = "Webserver URL"
}
