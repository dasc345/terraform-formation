module "alb_asg" {
  source             = "./modules/oxa-alb"
  enable             = "${lookup(var.alb_asg_enable, var.region) ? 1 : 0}"
  enable_registering = "${lookup(var.alb_asg_enable_registering, var.region) ? 1 : 0}"
  customer           = "${var.client}"
  project            = "${var.project}"
  role               = "front"

  # Behind the scene, ALB are enable or disable by alb_asg_enable_registering map
  # (according to region) in variables.tf global file
  # WARNING: ALB name can't contain dot "." and must be 32 char max

  region         = "${var.region}"
  alb_subnet_ids = ["${module.subnets.public_subnets_id}"]
  vpc_id         = "${module.oxa-network.vpc_id}"
  # Default is false
  alb_is_internal = false

  # TODO: Currently, ALB backend (target group parameters) are hard coded.

  env                      = "${var.env}"
  health_check_target      = "/up.php"
  enable_ssl               = false
  #listener_certificate_arn = "${aws_iam_server_certificate.san-lls.arn}"
  target_cidr_block        = ["${module.subnets.private_cidrs_block}"]
  # Default : alb_allowed_cidrs [ "0.0.0.0/0" ]
  alb_allowed_cidrs = ["0.0.0.0/0"]
}

output "prod_alb_asg_dns_name" {
  value = "${module.alb_asg.alb_dns_name}"
}
