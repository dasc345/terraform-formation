EC2 Terraform module
======================

A Terraform module to create an EC2 in AWS.
This instance will be pubilc (i.e. with EIP).
This EC2s can be attached to an AWS ELB.


Module Input Variables
----------------------

 - `number_of_ec2`      : number of similar instance to create
 - `customer`           : customer's name
 - `project`            : project's name
 - `environment`        : environment (staging, production, what else ...)
 - `service`            : role or service running on this EC2 (deploy, front, cache, ...)
 - `region`             : AWS Region location
 - `az`                 : List of AWS Avialability Zone inside the AWS Regions where the EC2 will be distributed
 - `ec2_image_id`       : AMI
 - `ec2_subnet_ids`     : List of ids of the AWS VPC **private** subnet where the EC2 will be distributed
 - `ec2_subnet_cidrs`   : CIDR of the previous 'ec2_subnet_id'
 - `ec2_hostnum_start`  : first position of the IP addres in the given CIDRs
 - `ec2_key_name`       : key pay to deploy inside the EC2
 - `ec2_security_group` : List of AWS Security Group to protect the EC2s
 - `alarm_actions`	: SNS arn to send metrics alarm to Mondash
 - `alarm_cpu_threshold`: Threshold for CPU metric alarm

Usage
-----

Here we create a single EC2 as deploy.
Inside a VPC created by the module "terraform-oxalide-aws".
Subnet is created by the module "oxa-subnets".
Security Group is created by the module "oxa-sg/sg_ssh".

```
module "deploy" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-ec2-multiaz-public.git"

  number_of_ec2 = "1"

  customer    = "${var.customer}"
  project     = "${var.project}"
  environment = "production"
  service     = "deploy"

  region      = "${var.region}"
  az          = ["${var.zones_production}"]

  ec2_subnet_ids    = ["${module.subnets-production.public_subnets_id}"]
  ec2_subnet_cidrs  = ["${module.subnets-production.public_cidrs_block}"]
  ec2_hostnum_start = "5"

  ec2_key_name = "${aws_key_pair.ssh_public_key.key_name}"
  ec2_image_id = "${var.ami_id}"
  ec2_type     = "t2.micro"

  ec2_security_group = [
    "${module.ssh-deploy-allow.security_group_id}",
  ]
}
```

Specify an alarm action (Not required but recommend for production environment to notify Mondash)

- `alerts_handler` have to be defined in your terraform

```
module "deploy" {
        ...
        alarm_actions = ["${module.alerts_handler.sns_cloudwatch_alerts_arn}"]
        ...
```

Change CPU threshold (Not required - Default 80)

```
module "deploy" {
        ...
        alarm_cpu_threshold = "75"
        ...
```

Outputs
=======

 - `ec2_instance_ids` : list of EC2's id
 - `ec2_private_ips`  : list of EC2's private IP address
 - `ec2_instance_azs` : list of EC2's Availability Zone
 - `ec2_subnet_ids`   : list of EC2' subnet's ID
 - `ec2_adm_records`  : list of DNS record to copy in ADM zone
 - `ec2_dns_records`  : list of DNS record to copy in public zone


Sources
=======

Authors
=======

Originally created and maintained by Hugues Lepesant [Oxalide](http://www.oxalide.com/)

License
=======

Apache 2 Licensed. See LICENSE for full details.
