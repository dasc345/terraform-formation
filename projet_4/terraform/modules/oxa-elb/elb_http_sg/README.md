oxa-elb//elb_http_sg
==================
A Terraform module to create an ELB with HTTP support only.  

It makes the following assumptions in its design:
* Your instances behind the ELB are in a VPC
* It only configures a listener for HTTP
* It create the associated AWS Security Group

It supports both (one or the other):
- Internal IP ELBs
- External IP ELBs

Input Variables
---------------

- `elb_name` - The friendly name of the ELB
- `elb_security_group` - A list of Security Groups to associate with the ELB
- `elb_is_internal` - Defaults to `false`, you can set to `true` to make the ELB have an internal IP
- `elb_subnets_ids` - A list a subnet to put the ELB in.
- `backend_port` - The port the service running on the EC2 insances will listen on.
- `backend_protocol` - The protocol the service running on the EC2 insances will route to.
- `health_check_target` - The URL that the ELB should use for health checks, e.g. `HTTP:80/health`
- `vpc_id` - The VPC ID
- `elb_allowed_cidrs` - List of CIDRs allowed to connect to this ELB

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
module "prod_elb_backend" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-elb.git//elb_http_sg"

  elb_name       = "${format("%s-%s-backend-elb", var.customer, var.project)}"
  elb_subnet_ids = ["${module.subnets-production.public_subnets_id}"]

  backend_port        = "80"
  backend_protocol    = "http"
  health_check_target = "HTTP:80/httprobe"

  elb_instance_ids = [
     "${module.backend.ec2_instance_ids}",
  ]

  vpc_id = "${module.oxa-network.vpc_id}"
  elb_allowed_cidrs = [ "0.0.0.0/0" ]
}

output "prod_elb_dns_name" {
  value = "${module.prod_elb_backend.elb_dns_name}"
}
```
