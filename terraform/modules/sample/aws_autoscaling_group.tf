resource "aws_autoscaling_group" "sample" {
  name                      = "sample"
  desired_capacity          = 2
  health_check_type         = "EC2"
  launch_configuration      = "${aws_launch_configuration.sample.name}"
  max_size                  = 2
  min_size                  = 1
  termination_policies      = ["OldestInstance", "ClosestToNextInstanceHour"]
  health_check_grace_period = 300
  target_group_arns         = ["${aws_alb_target_group.sample.arn}"]

  tag {
    key                 = "role"
    value               = "web"
    propagate_at_launch = true
  }

  vpc_zone_identifier = [
    "${aws_subnet.sample_public_a.id}",
    "${aws_subnet.sample_public_c.id}",
  ]
}
