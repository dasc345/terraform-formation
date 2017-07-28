oxa-elb//elb_web
=================
A Terraform module for creating an ELB with just HTTP support

It makes the following assumptions in its design:
* You have subnets in a VPC and that you want the ELB in two subnets
* You'll build all your instances with an Auto-Scaling Group (ASG)
  and you'll use the ASG to associate your instances with the ELB.
* Your instances behind the ELB will be in a VPC
* It only configures a listener for HTTPS
* It requires you've already uploaded an SSL certificate

It supports both (one or the other):
- Internal IP ELBs
- External IP ELBs

It's recommended you use this with
[sg_web](https://github.com/terraform-community-module/tf_aws_sg/tree/master/sg_web)

Input Variables
---------------

- `elb_name` - The friendly name of the ELB
- `elb_security_group` - The Security Group to associate with the ELB
- `elb_is_internal` - Defaults to `false`, you can set to `true` to make the ELB have an internal IP
- `elb_subnets_id` - The VPC subnet ID for AZ1
- `backend_port` - The port the service running on the EC2 insances will listen on.
- `health_check_target` - The URL that the ELB should use for health
- `ssl_certificate_id` - The ARN of the SSL Certificate

Outputs
------

- `elb_id`
- `elb_name`
- `elb_dns_name`

Usage
-----

You can use these in your terraform template with the following steps.


```
module "my_web_elb" {
  source = "git::ssh://git@oxalide.factory.git-01.adm:terraform/oxa-elb.git//elb_web"
  elb_name = "${var.elb_name}"
  elb_subnets_id = ["${module.subnets-production.public_subnets_id}"]
  backend_port = "${var.backend_port}"
  backend_protocol = "${var.backend_protocol}"
  health_check_target = "${var.health_check_target}"
  ssl_certificate_id  = "arn:aws:iam::123456789012:server-certificate/certName"

  elb_instance_ids = [ "${module.backend.ec2_instance_ids}" ]
}
```
