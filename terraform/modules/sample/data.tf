# aws ec2 describe-images --owners self --filters "Name=name,Values=sampleapp*"
data "aws_ami" "sample_app" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["sampleapp*"]
  }
}
