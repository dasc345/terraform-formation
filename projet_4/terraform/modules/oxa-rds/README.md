oxa-rds
=======
A Terraform module which contains a number of common configurations for AWS RDS.

Input Variables
---------------

- `instance_name`
- `instance_oxaname`
- `is_multi_az`
- `storage_type`
- `allocated_storage`
- `engine_type`
- `engine_version`
- `instance_class`
- `database_name`
- `database_user`
- `database_password`
- `db_parameter_group`
- `security_group_ids`
- `backup_retention_period`
- `alarm_actions`
- `alarm_cpu_threshold`

Outputs
-------


- `instance_id` - The ID of the RDS instance
- `instance_endpoint` - The Endpoint of the RDS instance
- `backup_retention` - The Backup Retention of the RDS instance
- `subnet_group_id` - The ID of the Subnet Group



Usage
-----

You can use these in your terraform template with the following steps.

1.) Adding a module resource to your template, e.g. `rds.tf`

```
module "myrds" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-rds.git"
  project     = "${var.project}"
  environment = "production"
  instance_name  = "myrds"
  instance_oxaname  = "customer.aws-region.myrds"
  instance_class = "${var.rds_instance_class}"
  allocated_storage = "${var.rds_allocated_storage}"
  storage_type      = "${var.rds_storage_type}"
  backup_retention = "${var.rds_backup_retention}"
  engine_type    = "${var.rds_engine_type}"
  engine_version = "${var.rds_engine_version}"
  database_name     = "${var.rds_database_name}"
  database_user     = "${var.rds_database_user}"
  database_password = "${var.rds_database_password}"
  security_group_ids = "${module.rds-in.security_group_id}"
  db_parameter_group = "${aws_db_parameter_group.parameter_group.name}"
  subnet_ids  = "${module.subnets-production.private_subnets_id}"
  is_multi_az = "${var.rds_is_multi_az}"
}
```

2.) Setting values for the following variables

- `rds_instance_class`
- `rds_allocated_storage`
- `rds_storage_type`
- `rds_backup_retention`
- `rds_engine_type`
- `rds_engine_version`
- `rds_database_name`
- `rds_database_user`
- `rds_database_password`
- `rds_security_group_ids`
- `rds_db_parameter_group`
- `rds_is_multi_az`

3.) Specify an alarm action (Not required but recommend for production environment to notify Mondash)

- `alerts_handler` have to be defined in your terraform

```
module "myrds" {
	...
	alarm_actions = ["${module.alerts_handler.sns_cloudwatch_alerts_arn}"]
	...
```

4.) Change CPU threshold (Not required - Default 80)

```
module "myrds" {
	...
	alarm_cpu_threshold = "75"
	...
```

Authors
=======

Inspired by [Terraform Community Module](https://github.com/terraform-community-modules/tf_aws_rds).
Created and maintained by [Brandon Burton](https://github.com/solarce) (brandon@inatree.org).

Forked by [Oxalide](http://www.oxalide.com) during Initiative Week.

License
=======

Apache 2 Licensed. See LICENSE for full details.
