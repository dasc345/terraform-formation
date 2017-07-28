resource "aws_subnet" "subnet_pub" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "172.16.10.0/24"
  availability_zone = "${data.aws_availability_zones.all.names[0]}"

  tags {
    Name = "formation-lls"
  }
}

data "aws_subnet" "subnet_pub" {
    filter {
       name = “tag:Name”
       values = [“formation-lls”]
     }
}


resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table_association" "main" {
  subnet_id      = "${aws_subnet.subnet_pub.id}"
  route_table_id = "${aws_route_table.main.id}"
}

resource "aws_security_group" "az" {
  name        = "az-${data.aws_availability_zones.all.names[0]}"
  description = "Open access within the AZ ${data.aws_availability_zones.all.names[0]}"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["${aws_subnet.subnet_pub.cidr_block}"]
  }
}
