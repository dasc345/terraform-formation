module "oxa-network" {
  source = "./modules/oxa-network"
  enable              = true
  cust_vpc_name       = "vpc-${var.env}-${var.client}"
  cust_vpc_cidr_block = "${lookup(zipmap(var.vpc_cidr_block_environment, split(",", lookup(var.cust_vpc_cidr_block, var.region))), var.env)}"
  suffix_vpn          = "production"

  oxa_vpc_dns_support   = true
  oxa_vpc_dns_hostnames = true
}
