module "autoscaling" {
  source       = "./modules/autoscaling"
  ec2_type     = "${lookup(var.front_type, var.region)}"
  bucket       = "${lookup(var.bucket_chef, var.region)}"
  asg_min_size = "${lookup(zipmap(var.asg_parameters, split(",", lookup(var.asg_parameters_value, var.region))), "min")}"
  asg_max_size = "${lookup(zipmap(var.asg_parameters, split(",", lookup(var.asg_parameters_value, var.region))), "max")}"

  #git_ref = "${var.git_ref}"

  ami           = "${var.asg_ami}"
  customer          = "${var.client}"
  project           = "${var.project}"
  region            = "${var.region}"
  environment       = "${var.env}"
  ec2_subnet_ids    = ["${module.subnets.private_subnets_id}"]
  target_group_arns = ["${module.alb_asg.alb_target_group_arn}"]

  ec2_security_groups = [
    "${module.ssh-front-in.security_group_id}",
    "${module.sg-monitoring-prod.security_group_id}",
    "${module.sg-frontend-alb-in.security_group_id}",
  ]
}
