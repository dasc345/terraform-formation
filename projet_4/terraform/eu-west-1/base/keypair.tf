resource "aws_key_pair" "ssh_public_key" {
  key_name = "${var.customer}-key"

  public_key = "REPLACE ME"
}
