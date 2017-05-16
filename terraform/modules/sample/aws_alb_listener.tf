resource "aws_alb_listener" "sample" {
  load_balancer_arn = "${aws_alb.sample.arn}"
  port              = "8080"

  default_action {
    target_group_arn = "${aws_alb_target_group.sample.arn}"
    type             = "forward"
  }
}
