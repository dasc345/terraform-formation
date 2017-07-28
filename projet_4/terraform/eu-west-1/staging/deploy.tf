module "ssh-deploy-allow" {
  source = "../../modules/oxa-security_groups/sg_ssh"

  security_group_name = "ssh-in"
  vpc_id              = "${data.terraform_remote_state.base_state.vpc_id}"
  source_cidr_block   = ["0.0.0.0/0"]
}

/*
 * EC2 Deploy
 * Will host Deploy on EC2.
 */

module "deploy" {
  source = "../../modules/oxa-ec2-multiaz-public"

  number_of_ec2 = "1"

  #ec2_type    = "t2.medium"
  ec2_type    = "c3.large"
  customer    = "${var.customer}"
  project     = "${var.project}"
  environment = "production"
  service     = "deploy"
  region      = "${var.region}"
  az          = ["${var.zones}"]

  ec2_image_id     = "${var.ami_id}"
  ec2_subnet_ids   = ["${module.subnets-staging.public_subnets_id}"]
  ec2_subnet_cidrs = ["${module.subnets-staging.public_cidrs_block}"]

  ec2_hostnum_start = "5"

  #ec2_key_name = "${aws_key_pair.ssh_public_key.key_name}"
  ec2_key_name = "${data.terraform_remote_state.base_state.key_name}"

  ec2_security_group = [
    "${module.efs_staging.ec2_security_group_id}",
    "${module.ssh-deploy-allow.security_group_id}",
    "${data.terraform_remote_state.base_state.sg_ssh_from_oxalide_id}",
    "${data.terraform_remote_state.production_state.sg_efs_production_id}",
  ]
}

output "deploy_records_adm" {
  value = "${module.deploy.ec2_adm_records}"
}

output "deploy_records_dns" {
  value = "${module.deploy.ec2_dns_records}"
}
