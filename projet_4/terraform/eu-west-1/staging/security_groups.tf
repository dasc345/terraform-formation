/*
 * Add here non existing AWS Security Groups
 *
 * SG modules : https://gitlab.oxalide.net/terraform/oxa-security_groups
 *
*/

module "ssh-from-deploy" {
  source = "../../modules/oxa-security_groups/sg_ssh"

  security_group_name = "ssh-from-deploy"
  vpc_id              = "${data.terraform_remote_state.base_state.vpc_id}"
  source_cidr_block   = ["${format("%s/32", element(module.deploy.ec2_private_ips, 0))}"]
}

resource "aws_security_group_rule" "ftp_deploy" {
  type        = "ingress"
  from_port   = 20
  to_port     = 21
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${module.ssh-deploy-allow.security_group_id}"
}

resource "aws_security_group_rule" "passive_ftp_deploy" {
  type        = "ingress"
  from_port   = 12000
  to_port     = 12100
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${module.ssh-deploy-allow.security_group_id}"
}
