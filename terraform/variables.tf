variable "aws_profile" {
  default = "setup-jenkins"
  description = "Profile to use from AWS CLI"
}

variable "region" {
  default = "eu-central-1"
}

variable "instance_type" {
  default = "t2.micro"
  description = "EC2 instance type. Note that t2.micro is free tier eligible for eu-central-1 region at the time of writing. Some regions may have t3.micro for free tier instead"
}

variable "environment" {
  default = "dev"
  description = "Only affects resource tags for now"
}

variable "my_ip" {
  default = "0.0.0.0/0"
  description = "Your public IP (or IP range) that will be allowed to access Jenkins. Format: X.X.X.X/X"
}

variable "my_ssh_pub_key" {
  description = "Your public SSH key to connect to EC2 instances"
}
