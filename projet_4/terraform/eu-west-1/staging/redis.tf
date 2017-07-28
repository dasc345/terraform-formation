/*
 * ElastiCache Magento Instance
 * Will host cache/sessions on ElastiCache.
 */

module "redis-in_staging" {
  source = "../../modules/oxa-security_groups/sg_redis"

  security_group_name = "redis-in_staging"
  vpc_id              = "${data.terraform_remote_state.base_state.vpc_id}"
  source_cidr_block   = ["${var.cidrs_private}"]
}

module "redis_staging" {
  source = "../../modules/oxa-elasticache/elasticache_redis"

  project     = "${var.project}"
  environment = "${var.env}"

  #instance_name        = "llsrp-redis-${var.env}"
  instance_name        = "llsrp-redis-stag"
  instance_oxaname     = "${var.customer}.${var.region}-${var.project}.redis-${var.env}"
  instance_type        = "${var.redis_instance_type}"
  instance_description = "myenterprise-redis-${var.env}"

  automatic_failover_enabled = "${var.redis_automatic_failover_enabled}"
  desired_clusters           = "${var.redis_desired_clusters}"

  engine_version  = "${var.redis_engine_version}"
  parameter_group = "${var.redis_parameter_group}"

  security_group_ids = "${module.redis-in_staging.security_group_id}"
  subnet_ids         = ["${module.subnets-staging.private_subnets_id}"]
}

# Output the Configuration Endpoint of the ElastiCache Instance
output "redis_staging_configuration_endpoint" {
  value = "${join(",", module.redis_staging.configuration_endpoint)}:6379"
}

# Output the Endpoint of the ElastiCache Instance
output "redis_staging_endpoint" {
  value = "${join(",", module.redis_staging.endpoint)}:6379"
}
