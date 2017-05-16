resource "aws_launch_configuration" "sample" {
  associate_public_ip_address = true
  depends_on                  = ["aws_internet_gateway.sample"]
  iam_instance_profile        = "${aws_iam_instance_profile.sample.id}"
  image_id                    = "${data.aws_ami.sample_app.id}"
  instance_type               = "${var.aws_launch_configuration_sample_instance_type}"
  name                        = "sample"
  security_groups             = ["${aws_security_group.sample_web.id}"]
  user_data                   = "#!/bin/bash\n/bin/bash ${var.aws_launch_configuration_sample_user_data}"
}
