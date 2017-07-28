output "vpc_id" {
  value = "${module.oxa-network.vpc_id}"
}

output "igw_id" {
  value = "${module.internet-gateway.igw_id}"
}

output "key_name" {
  value = "${aws_key_pair.ssh_public_key.key_name}"
}

output "sg_web_in_id" {
  value = "${module.web-in.security_group_id}"
}

output "rds_parameter_group_56_name" {
  value = "${aws_db_parameter_group.parameter_group_56.name}"
}

# output "certificat_mydomain_arn" {
#   value = "${data.aws_acm_certificate.mydomain.arn}"
# }

