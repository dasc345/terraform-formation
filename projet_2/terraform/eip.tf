# EIP
resource "aws_eip" "eip" {
  vpc = true
}

# EIP ASSOCIATION
resource "aws_eip_association" "eip_association" {
  instance_id   = "${aws_instance.terraform.id}"
  allocation_id = "${aws_eip.eip.id}"
}

output "eip" {
  value = "${aws_eip.eip.public_ip}"
}
