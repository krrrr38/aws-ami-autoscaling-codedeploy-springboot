resource "aws_route_table" "sample" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.sample.id}"
  }

  vpc_id = "${aws_vpc.sample.id}"
}
