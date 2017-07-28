output "app_name" {
  value = "${aws_codedeploy_app.codedeploy_app.name}"
}

output "deployer_role_arn" {
  value = "${aws_iam_role.codedeploy_iam_role.arn}"
}
