subnets terraform module
===========

A terraform module to provide a Private and Pubic Subnet in AWS VPC

Depends on :
 - VPC. Can be created using [Oxalide Network Module](https://gitlab.oxalide.net/terraform/oxa-network)
 - Internet Gateway. Can be created using module [oxa-igw](https://gitlab.oxalide.net/terraform/oxa-igw)


Module Input Variables
----------------------

- `vpc_id` - vpc id
- `igw_id` - igw id
- `name` - vpc name
- `public_subnets` - list of public subnet cidrs
- `private_subnets` - list of private subnet cidrs
- `azs` - list of AZs in which to distribute subnets
- `private_propagating_vgws` - list of VGWs the private route table should propagate
- `public_propagating_vgws` - list of VGWs the public route table should propagate

It's generally preferable to keep `public_subnets`, `private_subnets`, and `azs` to lists of the same length.

Usage
-----

```hcl
module "prod_subnets" {
  source = "git::https://gitlab.oxalide.net/terraform/oxa-subnets"

  name = "customer"
  environment = "prod"

  vpc_id = "${module.oxalide.vpc_id}"
  igw_id = "${module.igw.igw_id}"

  public_propagating_vgws = "${module.oxalide.vpn_gateway_id}"
  private_propagating_vgws = "${module.oxalide.vpn_gateway_id}"

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  azs      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

}
```

Outputs
=======

 - `private_subnets_id` - list of private subnet ids
 - `private_cidrs_block` - list of private subnet cidr blocks
 - `private_route_table_id` - list of private route table ids
 - `public_subnets_id` - list of public subnet ids
 - `public_cidrs_block` - list of public subnet cidr blocks
 - `public_route_table_id` - the public route table id
 - `nat_gateway_public_ips` - list of nat gateway public ips

Authors
=======

Originally created and maintained by [Casey Ransom](https://github.com/cransom)
Hijacked by [Paul Hinze](https://github.com/phinze)
Hijacked by Hugues Lepesant

License
=======

Apache 2 Licensed. See LICENSE for full details.
