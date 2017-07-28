/*
 *
 * Security Group Resource for Module
 *
 */

resource "aws_security_group" "security_group" {
  name        = "${var.security_group_name}"
  description = "Security Group ${var.security_group_name}"
  vpc_id      = "${var.vpc_id}"

  # allow traffic for TCP 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.source_cidr_block}"]
  }

  # allow traffic to outside
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name             = "${var.security_group_name}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxa-security_group//sg_ssh"
  }
}
