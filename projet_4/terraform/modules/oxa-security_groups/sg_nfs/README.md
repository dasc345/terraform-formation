sg_nfs terraform module
=======================

A terraform module with contains rules for nfs

Ports
-----
- TCP 2049 (TCP/UDP)

Input Variables
---------------

- `security_group_name` - The name for your security group, e.g. `bluffdale_web_stage1`
- `vpc_id` - The VPC this security group should be created in.
- `source_cidr_block` - The source CIDR Block
- `create_egress_rule` - create outgoing rule or not (boolean, default false)

Usage
-----

You can use these in your terraform template with the following steps.

```
module "sg_nfs" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-igw.git//sg_nfs/"
  security_group_name = "${var.security_group_name}-nfs"
  vpc_id = "${var.vpc_id}"
  source_cidr_block = "${var.source_cidr_block}"
}
```
