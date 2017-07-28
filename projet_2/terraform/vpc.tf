data "aws_availability_zones" "all" {}

resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_range}"

  tags {
    Name = "vpc-formation-lls"
  }
}

data "aws_vpc" "main" {
  id = "vpc-057c3a6d"
}

output "vpc_id" {
  value = "${data.aws_vpc.main.id}"
}
