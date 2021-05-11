module "eu-central-1" {
  source          = "./region"
  region          = "eu-central-1"
  base_cidr_block = var.base_cidr_block
}

module "eu-west-1" {
  source          = "./region"
  region          = "eu-west-1"
  base_cidr_block = var.base_cidr_block
}
