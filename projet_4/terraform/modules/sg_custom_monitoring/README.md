sg_monitoring terraform module
==============================

A customizable terraform module with contains rules for monitoring

Default Ports
-----
- UDP 123
- UDP 161 (SNMP)
- TCP 80 (HTTP)
- TCP 8080 (HTTP-ALT)
- TCP 443 (HTTPS)
- TCP 9300
- TCP 5672
- TCP 15672


Input Variables
---------------

- `security_group_name` - The name for your security group, e.g. `bluffdale_web_stage1`
- `vpc_id` - The VPC this security group should be created in.
-   `enabled_rules` - A map that enable/disable aws_security_group_rule
    * `default_allowed_tcp_port` - Default: `true` Boolean that allow above default tcp ports list
    * `default_allowed_udp_port` - Default: `true` Boolean that allow above default tcp ports list
    * `default_allowed_tcp_port_range` - Default: `true` Boolean that allow above default tcp ports range
    * `default_allowed_udp_port_range` - Default: `true` Boolean that allow above default tcp ports range
    * `custom_allowed_tcp_ports` - Default: `false` Boolean that allow user defined tcp ports
    * `custom_allowed_udp_ports` - Default: `false` Boolean that allow user defined udp ports
    * `allowed_icmp` - Default: `true` Boolean that allow ping
    * `allow_out` - Default: `true` Boolean that allow to get out 0.0.0.0/0

Usage
-----

You can use these in your terraform template with the following steps.

- Adding a module resource to your template, e.g. `20_sg_monitoring.tf`

```
module "sg_monitoring" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-security_groups//sg_monitoring"
  security_group_name = "${var.security_group_name}-monitoring"
  vpc_id = "${var.vpc_id}"
  enabled_rules = "${var.enabled_rules}"
}
```

- Override enabled_rules to enable some rules

```
variable "enabled_rules" {
  description = "Map to enable rule accordingly to your need"
  type = "map"

  default = {
    "default_allowed_tcp_port"       = true
    "default_allowed_udp_port"       = true
    "default_allowed_tcp_port_range" = true
    "default_allowed_udp_port_range" = true
    "custom_allowed_tcp_ports"       = false
    "custom_allowed_udp_ports"       = false
    "allowed_icmp"                   = true
    "allow_out"                      = true
  }
}
```

For instance, if you what to allow Mysql port `custom_allowed_tcp_ports` in the above map, copy this map to your root variable tf file and add port to allow.
# your need, override enabled_rules to enable it:

```
variable "custom_allowed_tcp_ingress_ports" {
  description = "List of allowed TCP port"
  type        = "list"
  default     = ["3306"]
}
```

- Adding resource to your EC2 instance, e.g. `10_ec2_www.tf` :

```
/*
 * EC2 Magento www
 * Will host the application on EC2.
 */
module "www" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-ec2-multiaz.git"
  #source = "../../../oxa-ec2-multiaz"
  number_of_ec2 = "3"
  customer      = "${var.customer}"
  project       = "${var.project}"
  environment   = "production"
  service       = "www"
  region        = "${var.region}"
  az            = ["${var.zones_production}"]
  vol_root_size = "30"
  vol_root_type = "gp2"
  vol_space_size = "50"
  vol_space_type = "gp2"
  /*
   * Subnets must be created using : https://gitlab.oxalide.net/terraform/oxa-subnets
   */
  ec2_subnet_ids    = ["${module.subnets-production.private_subnets_id}"]
  ec2_subnet_cidrs  = ["${module.subnets-production.private_cidrs_block}"]
  ec2_hostnum_start = "10"
  ec2_key_name      = "${aws_key_pair.ssh_public_key.key_name}"
  ec2_image_id      = "${var.ami_id}"
  ec2_type          = "m4.large"
  ec2_security_group = [
    "${module.ssh-from-deploy.security_group_id}",
    "${module.sg_monitoring.security_group_id}",
  ]
}
```

- Setting values for the following variables, either through `terraform.tfvars` or `-var` arguments on the CLI
    - security_group_name
    - vpc_id


TODO
---------------

- Add custom_allowed_tcp_port_range rule which implement allowed_ingress_tcp_port_range
