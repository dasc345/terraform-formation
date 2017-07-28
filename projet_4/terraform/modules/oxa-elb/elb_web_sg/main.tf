/*
 * Module: oxa-elb/elb_web_sg
 */

resource "aws_security_group" "elb" {
  name = "${format("%s_sg", var.elb_name)}"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.elb_allowed_cidrs}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.elb_allowed_cidrs}"]
  }
}

/*
 * ELB Resource for Module
 */
resource "aws_elb" "elb" {
  name            = "${var.elb_name}"
  subnets         = ["${var.elb_subnet_ids}"]
  internal        = "${var.elb_is_internal}"
  security_groups = ["${aws_security_group.elb.id}"]

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.backend_port}"
    instance_protocol = "${var.backend_protocol}"
  }

  listener {
    lb_port            = "443"
    lb_protocol        = "https"
    instance_port      = "${var.backend_port}"
    instance_protocol  = "${var.backend_protocol}"
    ssl_certificate_id = "${var.ssl_certificate_id}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.health_check_target}"
    interval            = 30
  }

  cross_zone_load_balancing = true

  instances = [
    "${var.elb_instance_ids}",
  ]

  tags {
    Name               = "${var.elb_name}"
    oxaname            = "${var.elb_oxaname}"
    Description        = "ELB Proxy Protocol"
    ManagementTool     = "Terraform"
    ManagementModule   = "oxa-elb//elb_web_sg"
    NotificationPeriod = "${var.notification_period}"
  }
}
