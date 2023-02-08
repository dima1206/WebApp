output "jenkins_controller_pub_ip" {
  value       = aws_instance.jenkins_controller.public_ip
  description = "Public IP for Jenkins controller"
}

output "jenkins_agent_pub_ip" {
  value       = aws_instance.jenkins_agent.public_ip
  description = "Public IP for Jenkins agent"
}
