/*
 *
 * Custom Security Group Resource for Module
 *
 */

resource "aws_security_group" "nfs" {
  name        = "${var.security_group_name}"
  description = "Security Group ${var.security_group_name}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "2049"
    to_port     = "2049"
    protocol    = "tcp"
    cidr_blocks = ["${var.source_cidr_block}"]
  }

  ingress {
    from_port   = "2049"
    to_port     = "2049"
    protocol    = "udp"
    cidr_blocks = ["${var.source_cidr_block}"]
  }

  tags {
    Name             = "${var.security_group_name}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxa-security_group//sg_nfs"
  }
}

resource "aws_security_group_rule" "allow_outgoing" {
  count = "${var.create_egress_rule}"

  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "aws_security_group.custom_security_group.id"
}
