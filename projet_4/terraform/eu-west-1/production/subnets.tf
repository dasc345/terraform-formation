# Subnets Production
module "subnets-production" {
  source = "../../modules/oxa-subnets"

  name        = "${var.customer}-${var.env}"
  environment = "${var.env}"

  vpc_id = "${data.terraform_remote_state.base_state.vpc_id}"
  igw_id = "${data.terraform_remote_state.base_state.igw_id}"

  public_subnets  = ["${var.cidrs_public}"]
  private_subnets = ["${var.cidrs_private}"]
  azs             = ["${var.zones}"]
}
