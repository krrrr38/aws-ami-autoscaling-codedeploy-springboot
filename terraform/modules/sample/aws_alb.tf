resource "aws_alb" "sample" {
  name = "sample"

  subnets = [
    "${aws_subnet.sample_public_a.id}",
    "${aws_subnet.sample_public_c.id}",
  ]

  security_groups = [
    "${aws_security_group.sample_alb.id}",
  ]
}
