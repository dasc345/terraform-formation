# Pick N az (same as ec2 count) among for current region
# Remember: It's generally preferable to keep public_subnets, private_subnets, and azs to lists of the same length.
resource "random_shuffle" "az" {
  input        = ["${data.aws_availability_zones.available.names}"]
  result_count = "${lookup(var.number_of_front, var.region)}"
}

# Remember: It's generally preferable to keep public_subnets, private_subnets, and azs to lists of the same length.
module "subnets" {
  source = "./modules/oxa-subnets"

  name        = "${var.client}"
  environment = "${var.env}"


  vpc_id = "${module.oxa-network.vpc_id}"
  igw_id = "${module.igw-prod.igw_id}"

  # TODO: Choix a été fait de split le subnet alloué en 8
  # soit 2 subnet public "10.133.176.128/25,10.133.178.128/25"
  # newbit = 3 et netnum 1 et 5 https://www.terraform.io/docs/configuration/interpolation.html#cidrsubnet-iprange-newbits-netnum-
  #
  public_subnets = [
    "${cidrsubnet(lookup(zipmap(var.vpc_cidr_block_environment, split(",", lookup(var.cust_vpc_cidr_block, var.region))), var.env), 3, 1)}",
    "${cidrsubnet(lookup(zipmap(var.vpc_cidr_block_environment, split(",", lookup(var.cust_vpc_cidr_block, var.region))), var.env), 3, 5)}",
  ]

  # et 2 subnet privé "10.133.176.0/25,10.133.178.0/25"
  private_subnets = [
    "${cidrsubnet(lookup(zipmap(var.vpc_cidr_block_environment, split(",", lookup(var.cust_vpc_cidr_block, var.region))), var.env), 3, 0)}",
    "${cidrsubnet(lookup(zipmap(var.vpc_cidr_block_environment, split(",", lookup(var.cust_vpc_cidr_block, var.region))), var.env), 3, 4)}",
  ]

  map_public_ip_on_launch = "${lookup(var.map_public_ip_on_launch, var.region)}"

  # Because some AZS returned by AWS API aren't really available depending on what kind of resource
  azs = "${split(",", lookup(var.enable_dynamic_azs, var.region) ? join(",", random_shuffle.az.result) : lookup(var.static_azs, var.region))}"

  #azs = "${split(",", lookup(var.static_azs, var.region))}"
}

output "staging_nat_gateway_public_ips" {
  value = "${module.subnets.nat_gateway_public_ips}"
}
