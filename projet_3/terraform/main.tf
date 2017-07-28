resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_range}"

  tags {
    "${var.key}" = "${var.value}"
  }
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

variable "cidr_range" {
  default = "10.0.0.0/16"
}

variable "key" {
  type = "map"

  default = {
    key = "val1"
  }
}

variable "value" {
  type = "map"

  default = {
    value = "val1"
  }
}
