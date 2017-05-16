resource "aws_iam_instance_profile" "sample" {
  name = "sample"
  role = "${aws_iam_role.sample_ec2.name}"
}
