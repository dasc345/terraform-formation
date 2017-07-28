/*
 * Module: oxa-elb/elb_web
 */

/*
 * ELB Resource for Module
 */
resource "aws_elb" "elb" {
  name            = "${var.elb_name}"
  subnets         = ["${var.elb_subnet_ids}"]
  internal        = "${var.elb_is_internal}"
  security_groups = ["${var.elb_security_group}"]

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
    Description        = "ELB WEB"
    ManagementTool     = "Terraform"
    ManagementModule   = "oxa-elb//elb_web"
    oxaname            = "${var.elb_oxaname}"
    NotificationPeriod = "${var.notification_period}"
  }
}
