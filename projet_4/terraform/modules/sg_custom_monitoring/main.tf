resource "aws_security_group" "monitoring" {
  name        = "${var.security_group_name}"
  description = "Security Group ${var.security_group_name}"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name             = "${var.security_group_name}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxa-security_group//sg_monitoring"
  }
}

resource "aws_security_group_rule" "default_allowed_tcp_port" {
  count = "${ lookup(var.enabled_rules, "default_allowed_tcp_port") ? length(var.default_allowed_tcp_ingress_ports) : 0}"

  type              = "ingress"
  from_port         = "${element(var.default_allowed_tcp_ingress_ports, count.index)}"
  to_port           = "${element(var.default_allowed_tcp_ingress_ports, count.index)}"
  protocol          = "tcp"
  cidr_blocks       = ["${var.source_cidr_block_monitoring}"]
  security_group_id = "${aws_security_group.monitoring.id}"
}

resource "aws_security_group_rule" "allowed_icmp" {
  count             = "${lookup(var.enabled_rules, "allowed_icmp") ? 1 : 0}"
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "tcp"
  cidr_blocks       = ["${var.source_cidr_block_monitoring}"]
  security_group_id = "${aws_security_group.monitoring.id}"
}

resource "aws_security_group_rule" "default_allowed_tcp_port_range" {
  count = "${lookup(var.enabled_rules, "default_allowed_tcp_port_range") ? length(keys(var.default_allowed_ingress_tcp_port_range)) : 0}"

  type              = "ingress"
  from_port         = "${element(split(",", lookup(var.default_allowed_ingress_tcp_port_range, count.index)), 0)}"
  to_port           = "${element(split(",", lookup(var.default_allowed_ingress_tcp_port_range, count.index)), 1)}"
  protocol          = "tcp"
  cidr_blocks       = ["${var.source_cidr_block_monitoring}"]
  security_group_id = "${aws_security_group.monitoring.id}"
}

resource "aws_security_group_rule" "default_allowed_udp_port" {
  count = "${lookup(var.enabled_rules, "default_allowed_udp_port") ? length(var.default_allowed_udp_ingress_ports) : 0}"

  type              = "ingress"
  from_port         = "${element(var.default_allowed_udp_ingress_ports, count.index)}"
  to_port           = "${element(var.default_allowed_udp_ingress_ports, count.index)}"
  protocol          = "udp"
  cidr_blocks       = ["${var.source_cidr_block_monitoring}"]
  security_group_id = "${aws_security_group.monitoring.id}"
}

resource "aws_security_group_rule" "default_allowed_udp_port_range" {
  count             = "${lookup(var.enabled_rules, "default_allowed_udp_port_range") ? length(keys(var.default_allowed_ingress_udp_port_range)) : 0}"
  type              = "ingress"
  from_port         = "${element(split(",", lookup(var.default_allowed_ingress_udp_port_range, count.index)), 0)}"
  to_port           = "${element(split(",", lookup(var.default_allowed_ingress_udp_port_range, count.index)), 1)}"
  protocol          = "udp"
  cidr_blocks       = ["${var.source_cidr_block_monitoring}"]
  security_group_id = "${aws_security_group.monitoring.id}"
}

resource "aws_security_group_rule" "custom_allowed_tcp_ports" {
  count = "${length(var.custom_allowed_tcp_ingress_ports)}"

  type              = "ingress"
  from_port         = "${element(var.custom_allowed_tcp_ingress_ports, count.index)}"
  to_port           = "${element(var.custom_allowed_tcp_ingress_ports, count.index)}"
  protocol          = "udp"
  cidr_blocks       = ["${var.source_cidr_block_monitoring}"]
  security_group_id = "${aws_security_group.monitoring.id}"
}

resource "aws_security_group_rule" "custom_allowed_udp_ports" {
  count = "${length(var.custom_allowed_udp_ingress_ports)}"

  type              = "ingress"
  from_port         = "${element(var.custom_allowed_udp_ingress_ports, count.index)}"
  to_port           = "${element(var.custom_allowed_udp_ingress_ports, count.index)}"
  protocol          = "udp"
  cidr_blocks       = ["${var.source_cidr_block_monitoring}"]
  security_group_id = "${aws_security_group.monitoring.id}"
}

resource "aws_security_group_rule" "allow_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.monitoring.id}"
}
