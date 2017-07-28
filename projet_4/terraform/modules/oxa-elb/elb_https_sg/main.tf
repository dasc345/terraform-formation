/*
 * Module: oxa-elb/elb_https
 */

resource "aws_security_group" "elb" {
  name = "${format("%s_sg", var.elb_name)}"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.elb_allowed_cidrs}"]
  }
}

resource "aws_elb" "elb" {
  name = "${var.elb_name}"

  security_groups = ["${aws_security_group.elb.id}"]
  subnets         = ["${var.elb_subnet_ids}"]

  internal = "${var.elb_is_internal}"

  listener {
    lb_port            = "443"
    lb_protocol        = "https"
    instance_port      = "${var.backend_port}"
    instance_protocol  = "https"
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
    Description        = "ELB HTTPS"
    ManagementTool     = "Terraform"
    ManagementModule   = "oxa-elb//elb_https_sg"
    NotificationPeriod = "${var.notification_period}"
  }
}
