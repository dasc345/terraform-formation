# Lookup AMI to use based on its ID if available or
# the following three tags otherwise:
# * customer
# * project
# * git_ref

data "aws_ami" "ami_to_use" {
  most_recent = true

  # This datasource is horribly hacked to be able
  # to handle both situation. If we have the ID
  # of the AMI, we just use 3 times the same filter.
  filter {
    name   = "${var.ami == "" ? "tag:customer" : "image-id"}"
    values = ["${var.ami == "" ? var.customer : var.ami}"]
  }

  filter {
    name   = "${var.ami == "" ? "tag:project" : "image-id"}"
    values = ["${var.ami == "" ? var.project : var.ami}"]
  }

  filter {
    name   = "${var.ami == "" ? "tag:git_ref" : "image-id"}"
    values = ["${var.ami == "" ? var.git_ref : var.ami}"]
  }
}

# Lookup VPC to use based on provided subnets
data "aws_subnet" "first_subnet" {
  id = "${var.ec2_subnet_ids[0]}"
}

data "aws_vpc" "vpc" {
  id = "${data.aws_subnet.first_subnet.vpc_id}"
}
