# Internet Gateway
module "internet-gateway" {
  source = "../../modules/oxa-igw"

  name   = "${var.customer}-igw"
  vpc_id = "${module.oxa-network.vpc_id}"
}
