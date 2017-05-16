resource "aws_route_table_association" "sample_a" {
  route_table_id = "${aws_route_table.sample.id}"
  subnet_id      = "${aws_subnet.sample_public_a.id}"
}

resource "aws_route_table_association" "sample_c" {
  route_table_id = "${aws_route_table.sample.id}"
  subnet_id      = "${aws_subnet.sample_public_c.id}"
}
