/*
 *
 * Security Group Resource for Module HTTPS only
 *
 */

resource "aws_security_group" "https_only" {
  name        = "${var.security_group_name}"
  description = "Security Group ${var.security_group_name}"
  vpc_id      = "${var.vpc_id}"

  # allow traffic for TCP 443
  ingress {
    from_port   = 443
    to_port     = 443
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
    ManagementModule = "oxa-security_group//sg_https_only"
  }
}
