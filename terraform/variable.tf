variable "aws_region" {
  default = "ap-northeast-1"
}

variable "aws_launch_configuration_sample_instance_type" {
  default = "t2.micro"
}

variable "aws_launch_configuration_sample_user_data" {
  default = "/ops/user-data.sh"
}
