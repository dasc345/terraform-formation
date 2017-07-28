# vim:set expandtab tabstop=2 shiftwidth=2:

resource "aws_vpc" "main" {
  cidr_block           = "${var.cust_vpc_cidr_block}"
  enable_dns_support   = "${var.oxa_vpc_dns_support}"
  enable_dns_hostnames = "${var.oxa_vpc_dns_hostnames}"

  tags {
    Name = "${var.cust_vpc_name}"
  }
}
