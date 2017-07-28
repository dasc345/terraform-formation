sg_rds terraform module
==============================

A Terraform security group module for RDS.

Ports
-----
- TCP 3306 (MYSQL)
ou
- TCP 5432 (POSTGRES)

Input Variables
---------------

- `security_group_name` - The name for your security group, e.g. `bluffdale_web_stage1`.
- `vpc_id` - The VPC this security group should be created in.
- `source_cidr_block` - The source CIDR block, defaults to `0.0.0.0/0` for this module. Must be a list.

Usage
-----

You can use these in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. `main.tf`

```
module "sg_rds" {
  source = "../../modules/oxa-security_groups/sg_rds"
  security_group_name = "${var.security_group_name}-rds"
  vpc_id = "${var.vpc_id}"
  source_cidr_block = "${var.source_cidr_block}"
  # Optional, mysql by default:
  type = "postgres"
}
```

2. Setting values for the following variables, either through `terraform.tfvars` or `-var` arguments on the CLI

- security_group_name
- vpc_id
- source_cidr_block
