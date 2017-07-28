# EIP
resource "aws_eip" "eip" {
  count = "${var.number_of_ec2}"
  vpc   = true
}

# EIP ASSOCIATION
resource "aws_eip_association" "eip_association" {
  count = "${var.number_of_ec2}"

  instance_id   = "${element(aws_instance.ec2.*.id, count.index)}"
  allocation_id = "${element(aws_eip.eip.*.id, count.index)}"
}
