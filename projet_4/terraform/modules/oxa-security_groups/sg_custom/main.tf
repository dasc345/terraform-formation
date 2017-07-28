/*
 *
 * Custom Security Group Resource for Module
 *
 */

resource "aws_security_group" "custom_security_group" {
  name        = "${var.security_group_name}"
  description = "Security Group ${var.security_group_name}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${var.from_port}"
    to_port     = "${var.to_port}"
    protocol    = "${var.protocol}"
    cidr_blocks = ["${var.source_cidr_block}"]
  }

  tags {
    Name             = "${var.security_group_name}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxa-security_group//sg_custom"
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
