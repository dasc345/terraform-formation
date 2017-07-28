module "oxa-network" {
  source = "../../modules/oxa-network"

  cust_vpc_name       = "vpc-${var.customer}"
  cust_vpc_cidr_block = "${var.cust_vpc_cidr_block}"

  oxa_vpc_dns_support   = "${var.vpc_dns_support}"
  oxa_vpc_dns_hostnames = "${var.vpc_dns_hostnames}"
}
