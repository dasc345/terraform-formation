/*
 * EFS Backend Magento
 * Will host static files.
 */

module "efs_staging" {
  source = "../../modules/oxa-efs"

  customer    = "${var.customer}"
  project     = "${var.project}"
  environment = "${var.env}"
  service     = "efs_${var.env}"
  region      = "${var.region}"

  vpc_id = "${data.terraform_remote_state.base_state.vpc_id}"

  efs_subnet_count = "${length(var.cidrs_private)}"
  efs_subnet_ids   = ["${module.subnets-staging.private_subnets_id}"]
}

output "efs_staging_dns_name" {
  value = "${join(",", module.efs_staging.mount_target_dns_name)}"
}

/*
 * EC2 Backend Magento
 * Will host the application on EC2.
 */

module "backend_staging" {
  source = "../../modules/oxa-ec2-multiaz"

  number_of_ec2 = "2"
  customer      = "${var.customer}"
  project       = "${var.project}"
  environment   = "${var.env}"
  service       = "backendpp"
  region        = "${var.region}"
  az            = ["${var.zones}"]

  /*
   * Subnets must be created using : https://gitlab.oxalide.net/terraform/oxa-subnets
   */

  ec2_subnet_ids    = ["${module.subnets-staging.private_subnets_id}"]
  ec2_subnet_cidrs  = ["${module.subnets-staging.private_cidrs_block}"]
  ec2_hostnum_start = "10"
  ec2_key_name      = "${data.terraform_remote_state.base_state.key_name}"
  ec2_image_id      = "${var.ami_id}"
  ec2_type          = "${var.backend_ec2_type}"
  ec2_security_group = [
    "${module.efs_staging.ec2_security_group_id}",
    "${module.ssh-from-deploy.security_group_id}",
    "${data.terraform_remote_state.base_state.sg_ssh_from_oxalide_id}",
    "${data.terraform_remote_state.base_state.sg_web_in_id}",
  ]
}

output "backend_staging_records_adm" {
  value = "${module.backend_staging.ec2_adm_records}"
}
