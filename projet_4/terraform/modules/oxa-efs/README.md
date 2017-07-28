# Terraform module to create an EFS volume

This module create an EFS filesystem.
It create the mount target for given subnets.
And create the needed Security Group to allow NFS mount.



Module Input Variables
======================

 - `customer`           : customer's name
 - `project`            : project's name
 - `environment`        : environment (staging, production, what else ...)
 - `service`            : role or service running on this EC2 (deploy, front, cache, ...)
 - `region`             : AWS Region location
 - `vpc_id`             : vpc id
 - `efs_subnet_count`   : number of subnet where to create EFS endpoint. Length = Number of `efs_subnet_id`
 - `efs_subnet_id`      : ids of the AWS VPC **private** subnet allowed to mount this EFS
 - `performance_mode`   : (Optional) The file system performance mode. Can be either -generalPurpose- or -maxIO-"



Usage
=====

```
module "shared" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-efs.git"

  customer          = "${var.customer}"
  project           = "${var.project}"
  environment       = "production"
  service           = "deploy"
  region            = "${var.aws_region}"
  vpc_id            = "${module.oxalide.vpc_id}"
  efs_subnet_count  = "${length(var.cidrs_private_production)}"
  efs_subnet_ids    = ["${module.subnets-production.private_subnets_id}"]
  performance_mode  = "generalPurpose"
}
```

The Security Group "module.shared.ec2_security_group_id" must be added to the Security Group attached to the EC2 which will mount the EFS volume.

Example:
--------

Using "oxa-ec2-multiaz" module.

```
  ec2_security_group = [
    "${module.sshin.security_group_id}",
    "${module.shared.ec2_security_group_id}"
  ]
```

Outputs
=======

 - `file_system_id`   : EFS's id
 - `mount_target_ids` : mount target id for each subnet
 - `mount_target_interface_ids` : mount target efs network interface id
 - `ec2_security_group_id` : EC2 AWS Security Group id
 - `mnt_security_group_id` : Mnt AWS Security Group id



Sources
=======

https://github.com/manheim/tf_efs_mount

Authors
=======

Originally created by Manheim, Atlanta, GA.
Maintained by Hugues Lepesant [Oxalide](http://www.oxalide.com/)

License
=======

Apache 2 Licensed. See LICENSE for full details.
