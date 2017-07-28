oxa-elasticache for redis
=======
A Terraform module which contains a number of common configurations for AWS ElastiCache Redis.

Input Variables
---------------

- `instance_name`
- `instance_oxaname`
- `instance_type`
- `instance_description`
- `automatic_failover_enabled`
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

1.) Adding a module resource to your template, e.g. `redis.tf`

```
module "myredis" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-elasticache.git//elasticache_redis"
  project     = "${var.project}"
  environment = "production"
  instance_name        = "myredis"
  instance_oxaname        = "customer.aws-region.myredis"
  instance_type        = "${var.redis_instance_type}"
  instance_description = "myredis"
  automatic_failover_enabled = "${var.redis_automatic_failover_enabled}"
  desired_clusters           = "${var.redis_desired_clusters}"
  engine_version  = "${var.redis_engine_version}"
  parameter_group = "${var.redis_parameter_group}"
  security_group_ids = "${module.redis-in.security_group_id}"
  subnet_ids         = ["${module.subnets-production.private_subnets_id}"]
}
```

2.) Setting values for the following variables

- `redis_instance_type`
- `redis_automatic_failover_enabled`
- `redis_desired_clusters`
- `redis_engine_version`
- `redis_parameter_group`

3.) Specify an alarm action (Not required but recommend for production environment to notify Mondash)

- `alerts_handler` have to be defined in your terraform

```
module "myredis" {
        ...
        alarm_actions = ["${module.alerts_handler.sns_cloudwatch_alerts_arn}"]
        ...
```

4.) Change CPU threshold (Not required - Default 80)

```
module "myredis" {
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
