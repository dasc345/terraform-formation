oxa-elb//elb_ssl
=================
A Terraform module for creating an ELB with SSL support (proxy protocol).

It makes the following assumptions in its design:
* You have subnets in a VPC and that you want the ELB in two subnets
* Your instances behind the ELB will be in a VPC
* It requires you've already uploaded an SSL certificate to EC2

It supports both (one or the other):
- Internal IP ELBs
- External IP ELBs

Input Variables
---------------

- `elb_name` - The friendly name of the ELB
- `elb_security_group` - The Security Group to associate with the ELB
- `elb_is_internal` - Defaults to `false`, you can set to `true` to make
   the ELB have an internal IP
- `elb_subnet_ids` - The VPC subnets ID for AS
- `frontend_port` - The port the service running to listen on.
- `backend_port` - The port the service running on the EC2 insances will listen on.

Outputs
------

- `elb_id`
- `elb_name`
- `elb_dns_name`

Usage
-----

You can use these in your terraform template with the following steps.

1.) Adding a module resource to your template, e.g. `main.tf`

```
module "my_tcp_elb" {
  source          = "git::ssh://git@oxalide.factory.git-01.adm:terraform/oxa-elb.git//elb_ssl"
  elb_name        = "${var.elb_name}"
  elb_subnet_ids  = "${module.subnets-production.public_subnets_id}"
  frontend_port   = "443"
  backend_port    = "443"
}
```
