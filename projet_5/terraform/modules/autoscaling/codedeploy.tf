module "chefdeployapp" {
  source = "../codedeploy"
  name   = "${var.customer}-${var.project}-${var.environment}-chef"
}

resource "aws_codedeploy_deployment_group" "chefdeploygroup" {
  app_name              = "${module.chefdeployapp.app_name}"
  deployment_group_name = "${var.customer}-${var.project}-${var.environment}-chef"
  service_role_arn      = "${module.chefdeployapp.deployer_role_arn}"
  autoscaling_groups    = ["${aws_autoscaling_group.asg.id}"]
}
