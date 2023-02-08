variable "region" {
  default = "eu-central-1"
}

variable "aws_profile" {
  default = "setup-jenkins"
  description = "Profile to use from AWS CLI"
}

variable "environment" {
  default = "dev"
  description = "Only affects resource tags for now"
}

variable "my_ip" {
  default = "0.0.0.0/0"
  description = "Your public IP (or IP range) that will be allowed to access Jenkins. Format: X.X.X.X/X"
}
