module "eu-central-1" {
  source          = "./modules/vpc"
  region          = "eu-central-1"
  base_cidr_block = var.base_cidr_block
  entity_name = var.entity_name
  env = var.env
  owner_name = var.owner_name
}

module "eu-west-1" {
  source          = "./modules/vpc"
  region          = "eu-west-1"
  base_cidr_block = var.base_cidr_block
  entity_name = var.entity_name
  env = var.env
  owner_name = var.owner_name
}
