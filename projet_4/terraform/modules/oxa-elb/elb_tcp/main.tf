/*
 * Module: oxa-elb/elb_proxy_protocol
 */

resource "aws_elb" "elb" {
  name            = "${var.elb_name}"
  subnets         = ["${var.elb_subnet_ids}"]
  internal        = "${var.elb_is_internal}"
  security_groups = ["${var.elb_security_group}"]

  listener {
    lb_port           = "${var.frontend_port}"
    lb_protocol       = "tcp"
    instance_port     = "${var.backend_port}"
    instance_protocol = "tcp"
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 120
  connection_draining         = true
  connection_draining_timeout = 400

  instances = [
    "${var.elb_instance_ids}",
  ]

  tags {
    Name               = "${var.elb_name}"
    Description        = "ELB Proxy Protocol"
    ManagementTool     = "Terraform"
    ManagementModule   = "oxa-elb//elb_tcp"
    NotificationPeriod = "${var.notification_period}"
  }
}

resource "aws_proxy_protocol_policy" "elb" {
  load_balancer = "${aws_elb.elb.name}"

  instance_ports = [
    "${var.frontend_port}",
  ]
}
