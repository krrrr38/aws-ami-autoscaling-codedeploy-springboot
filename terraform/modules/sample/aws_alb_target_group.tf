resource "aws_alb_target_group" "sample" {
  name     = "sample"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.sample.id}"

  health_check {
    interval            = 5
    path                = "/status/check"
    port                = 8080
    timeout             = 2
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
