/*
 * Add here non existing AWS Security Groups
 *
 * SG modules : https://gitlab.oxalide.net/terraform/oxa-security_groups
 *
*/

module "web-in" {
  source = "../../modules/oxa-security_groups/sg_web"

  security_group_name = "web-in"
  vpc_id              = "${module.oxa-network.vpc_id}"
  source_cidr_block   = ["0.0.0.0/0"]
}

module "ssh-from-office" {
  source = "../../modules/oxa-security_groups/sg_ssh"

  security_group_name = "ssh-from-office"
  vpc_id              = "${module.oxa-network.vpc_id}"

  source_cidr_block = [
    "10.2.71.0/24",
  ]
}
