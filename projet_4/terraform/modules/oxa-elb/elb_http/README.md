oxa-elb//elb_http
==================
A Terraform module for creating an ELB with just HTTP support

It makes the following assumptions in its design:
* You have subnets in a VPC and that you want the ELB in two subnets  
* Your instances behind the ELB will be in a VPC
* It only configures a listener for HTTP

It supports both (one or the other):
- Internal IP ELBs
- External IP ELBs

It's recommended you use this with
[sg_http](https://gitlab.oxalide.net/terraform/oxa-security_groups/tree/master/sg_web)

Input Variables
---------------

- `elb_name` - The friendly name of the ELB
- `elb_oxaname` - The Oxalide name of the ELB - Monitoring Part
- `elb_security_group` - A list of Security Groups to associate with the ELB
- `elb_is_internal` - Defaults to `false`, you can set to `true` to make
   the ELB have an internal IP
- `elb_subnets_ids` - A list a subnet to put the ELB in.
- `backend_port` - The port the service running on the EC2 insances will listen on.
- `backend_protocol` - The protocol the service running on the EC2 insances will route to.
- `health_check_target` - The URL that the ELB should use for health checks, e.g. `HTTP:80/health`

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
module "prod_elb_cache" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-elb.git//elb_http"

  elb_name       = "${format("%s-%s-cache-elb", var.customer, var.project)}"
  elb_oxaname    = "customer.aws-region.elb-type"
  elb_subnet_ids = ["${module.subnets-production.public_subnets_id}"]

  elb_security_group = [
    "${module.cache-web-sg.security_group_id}",
  ]

  backend_port        = "80"
  backend_protocol    = "http"
  health_check_target = "HTTP:80/httprobe"

  elb_instance_ids = [
    "${concat(
        module.cache-az1.ec2_instance_ids,
        module.cache-az2.ec2_instance_ids
      )}",
  ]

  /*
  * This syntax works too
  *  elb_instance_ids = [
  *    "${module.cache-az1.ec2_instance_ids}",
  *    "${module.cache-az2.ec2_instance_ids}",
  *  ]
  */
}
```
