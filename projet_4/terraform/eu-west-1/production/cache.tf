/*
 * EC2 Cache Varnish
 * Will host Varnish on EC2.
 */

module "cache_production" {
  source = "../../modules/oxa-ec2-multiaz"

  number_of_ec2 = "2"
  customer      = "${var.customer}"
  project       = "${var.project}"
  environment   = "${var.env}"
  service       = "cache"
  region        = "${var.region}"
  az            = ["${var.zones}"]

  /*
   * Subnets must be created using : https://gitlab.oxalide.net/terraform/oxa-subnets
   */

  ec2_subnet_ids    = ["${module.subnets-production.private_subnets_id}"]
  ec2_subnet_cidrs  = ["${module.subnets-production.private_cidrs_block}"]
  ec2_hostnum_start = "20"
  ec2_key_name      = "${data.terraform_remote_state.base_state.key_name}"
  ec2_image_id      = "${var.ami_id}"
  ec2_type          = "${var.cache_ec2_type}"
  ec2_security_group = [
    #"${module.ssh-from-deploy.security_group_id}",
    "${data.terraform_remote_state.base_state.sg_ssh_from_oxalide_id}",

    "${data.terraform_remote_state.staging_state.sg_ssh_from_deploy_id}",
    "${data.terraform_remote_state.base_state.sg_web_in_id}",
  ]
}

output "cache_production_records_adm" {
  value = "${module.cache_production.ec2_adm_records}"
}

# ELB
module "elb_cache_production" {
  source = "../../modules/oxa-elb/elb_web"

  elb_name       = "${format("%s-%s-cache-elb", var.customer, var.env)}"
  elb_oxaname    = "${format("%s.%s.cache-elb", var.customer, var.env)}"
  elb_subnet_ids = ["${module.subnets-production.public_subnets_id}"]

  elb_security_group = [
    "${data.terraform_remote_state.base_state.sg_web_in_id}",
  ]

  backend_port        = "80"
  backend_protocol    = "http"
  health_check_target = "HTTP:80/httpprobe"

  #ssl_certificate_id  = "${data.terraform_remote_state.base_state.certificat_mydomain_arn}"

  elb_instance_ids = [
    "${module.cache_production.ec2_instance_ids}",
  ]
}

output "elb_cache_production_dns_name" {
  value = "${module.elb_cache_production.elb_dns_name}"
}
