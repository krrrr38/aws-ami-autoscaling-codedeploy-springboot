resource "aws_internet_gateway" "sample" {
  vpc_id = "${aws_vpc.sample.id}"

  tags {
    Name = "sample"
  }
}
