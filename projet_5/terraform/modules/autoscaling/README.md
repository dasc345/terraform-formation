ASG Terraform module
======================

A Terraform module to create an Autoscaling Group in AWS.  

This module creates an Autoscaling Group with his launch configuration.

You must provide all input variables, all others are optional, with default
values.

Module Input Variables
----------------------

 - `customer`            : customer's name
 - `project`             : project's name
 - `environment`         : Environment name : production, staging, devel, ...
 - `bucket`              : S3 bucket in which your Chef code is located
 - `region`	 					   : Region AWS
 - `ec2_subnet_ids`      : List of Subnet ID where EC2 are launched by Launch Configuration
 - `target_group_arns`   : (optional) List of target Group ARNS that apply to this AutoScaling Group


Note: a default security group is created that allows SSH access from Oxalide's
networks.

How to specify an AMI
---------------------

You have 2 ways of specifying an AMI. You must use **one of these two** inputs:

 - `ami`: just specify the ID you want,
 - `git_ref`: the value of the `git_ref` tag (commit ID of the Chef repository
for which the AMI was built).

Using the `git_ref` is the preferred way. In this case, this module will search
the AMI to use based on the value of those 3 tags:

 - `customer`
 - `project`
 - `git_ref`

If you follow Oxalide's standard way of building AMIs ([available here](https://gitlab.oxalide.net/oxalide/build-ami-template)), your AMIs should
be correctly tagged.

**Attention**: As we search for the AMI based on the value of the `git_ref` tag,
this means that Terraform **will not** automatically use new AMIs. You **must**
specify the `git_ref` you want to use.

This is the intended behavior: this allows Terraform to do fully idempotent
deployments. In GitlabCI, you will be able to re-run a "Terraform Plan" job from
months ago and it will find the same AMI as it did the first time, allowing you
to rollback precisely to the right Chef and AWS configuration.

Usage
-----

Specifying the AMI with the `git_ref`, `customer` and `project` tags:

```
module "autoscaling" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/autoscaling.git"

  git_ref             = "${var.git_ref}"
  customer            = "${var.customer}"
  project             = "${var.project}"
  region              = "${var.region}"
  environment         = "production"
  ec2_subnet_ids      = "${var.ec2_subnet_ids}"
  ec2_security_groups = "${var.ec2_security_groups}"
  #optional
  target_group_arns	    = ["${var.target_group_arns}"]
}
```

Specifying the AMI directly by its ID:

```
module "autoscaling" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/autoscaling.git"

  ami                 = "${var.ami_id}"
  customer            = "${var.customer}"
  project             = "${var.project}"
  region              = "${var.region}"
  environment         = "production"
  ec2_subnet_ids      = "${var.ec2_subnet_ids}"
  ec2_security_groups = "${var.ec2_security_groups}"
}
```

Other useful options
--------------------

Other options you will probably use:

 - `ec2_type`: EC2 instance type (default: `t2.micro`),
 - `asg_(min|max)_size`: Min and Max size of the autoscaling group (defaults: 2 and 4),
 - `threshold_(down|up)`: Thresholds for scaling up and down (default: 40% and 70% of `CPUUtilization`),
 - `roles`: Additional IAM roles to include in the instances' profile,
 - `load_balancers`: Load balancers to associate to the autoscaling group (there is none by default),
 - `ec2_security_groups` : List of AWS Security Groups for for the autoscaling group.

You can lookup all other options in the `variables.tf` file.

Outputs
=======

 - `to_be_defined`  :

Schema
======

This module implements the red part of the following schema (the other part is
implemented in your Chef configuration repository, like in [this one](https://gitlab.oxalide.net/oxalide/build-ami-template)).

![schema](./schema.png)

Authors
=======

Originally created and maintained for [Oxalide](http://www.oxalide.com/) by:
 * [Arnaud Bazin](https://gitlab.oxalide.net/arnaud.bazin)
 * [Nicolas Vion](https://gitlab.oxalide.net/nvion)
 * [Théo Chamley](https://gitlab.oxalide.net/theo.chamley)
