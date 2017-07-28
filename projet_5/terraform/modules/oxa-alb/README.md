VERSION ALPHA - USE WITH CAUTION (CHIEN MECHANT)
====================

This module use a dirty workaround to avoid this bug https://github.com/hashicorp/terraform/issues/8684

alb_web_sg
==================
A Terraform module for creating an ALB with HTTP and HTTPS support

It makes the following assumptions in its design:
* Your instances behind the ALB are in a VPC
* HTTP & HTTP listener are partially hardcoded, because there accept differents parameters (eg. ssl_policy, certificate_arn for HTTPS protocol)
* It create the associated AWS Security Group (fully parameterable unlike listener)

It supports both (one or the other):
- Internal IP ALBs
- External IP ALBs

Input Variables
---------------

- `vpc_id` - The VPC ID
- `alb_allowed_cidrs` - List of CIDRs allowed to connect to this ALB
- `alb_ports_ingress` - list of tcp ingress Security Groups to associate with the ALB (Defaults: ["80", "443"])
- `alb_is_internal` - Defaults to `false`, you can set to `true` to make the ALB have an internal IP
- `alb_subnets_ids` - A list a subnet to put the ALB in.
- `default_target_group_port` - The port the service running on the EC2 insances will listen on (backend port)
- `default_target_group_protocol` - The protocol the service running on the EC2 insances will route to (backend protocol)
- `health_check_target` - The URL that the ALB should use for health checks, e.g. `HTTP:80/health`
- `ssl_certificate_id` - The ARN of the SSL Certificate

Outputs
------

- `alb_id`
- `alb_name`
- `alb_dns_name`
- `alb_arn`
- `alb_arn_suffix`
- `alb_listener_https_arn`
- `alb_listener_http_arn`
- `alb_zone_id`
- `alb_oxaname` - Make resource able to being probed by [DT autodiscovery](https://synapse.oxalide.net/x/cbN3)

Usage
-----

You can use these in your terraform template with the following steps.

1.) Adding a module resource to your template, e.g. `main.tf`

```
module "prod_alb_backend" {
  source = "./modules/alb_module"

  enable   = "${lookup(var.alb_enable, var.region) ? 1 : 0}"
  customer = "${var.customer}"
  project  = "${var.project}"
  role = "front"

  alb_subnet_ids = ["${module.subnets-production.public_subnets_id}"]

  ssl_certificate_id  = "arn:aws:iam::123456789012:server-certificate/certName"
  health_check_target = "HTTP:80/up.php"

  vpc_id = "${module.oxa-network.vpc_id}"
  alb_allowed_cidrs = [ "0.0.0.0/0" ]
}

output "prod_alb_dns_name" {
  value = "${module.prod_alb_backend.alb_dns_name}"
}
```
