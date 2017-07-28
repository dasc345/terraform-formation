oxa-elasticache for memcached
=======
A Terraform module which contains a number of common configurations for AWS ElastiCache Memcached.

Input Variables
---------------

- `instance_name`
- `instance_oxaname`
- `instance_type`
- `az_mode`
- `desired_clusters`
- `engine_version`
- `parameter_group`
- `alarm_actions`
- `alarm_cpu_threshold`

Outputs
-------

- `instance_id` - The ID of the ElastiCache Instance
- `port` - The Port of the ElastiCache Instance
- `configuration_endpoint` - The Configuration Endpoint of the ElastiCache Instance
- `endpoint` - The Endpoint of the ElastiCache Instance

Usage
-----

You can use these in your terraform template with the following steps.

1.) Adding a module resource to your template, e.g. `memcached.tf`

```
module "mymemcached" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-elasticache.git//elasticache_memcached"
  project     = "${var.project}"
  environment = "production"
  instance_name = "mymemcached"
  instance_oxaname = "customer.aws-region.mymemcached"
  instance_type = "${var.memcached_instance_type}"
  az_mode          = "${var.memcached_az_mode}"
  desired_clusters = "${var.memcached_desired_clusters}"
  engine_version = "${var.memcached_engine_version}"
  parameter_group = "${var.memcached_parameter_group}"
  security_group_ids = "${module.memcached-in.security_group_id}"
  subnet_ids         = ["${module.subnets-production.private_subnets_id}"]
}
```

2.) Setting values for the following variables

- `memcached_instance_type`
- `memcached_az_mode`
- `memcached_desired_clusters`
- `memcached_engine_version`
- `memcached_parameter_group`

3.) Specify an alarm action (Not required but recommend for production environment to notify Mondash)

- `alerts_handler` have to be defined in your terraform

```
module "mymemcached" {
        ...
        alarm_actions = ["${module.alerts_handler.sns_cloudwatch_alerts_arn}"]
        ...
```

4.) Change CPU threshold (Not required - Default 80)

```
module "mymemcached" {
        ...
        alarm_cpu_threshold = "75"
        ...
```

Authors
=======

Inspired by [Azavea](https://github.com/azavea/terraform-aws-memcached-elasticache).
Created and maintained by [Azavea](https://github.com/azavea).

Forked by [Oxalide](http://www.oxalide.com) during Initiative Week.

License
=======

Apache 2 Licensed. See LICENSE for full details.
