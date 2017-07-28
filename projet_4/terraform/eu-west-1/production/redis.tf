/*
 * ElastiCache Magento Instance
 * Will host cache/sessions on ElastiCache.
 */

module "redis-in_production" {
  source = "../../modules/oxa-security_groups/sg_redis"

  security_group_name = "redis-in_production"
  vpc_id              = "${data.terraform_remote_state.base_state.vpc_id}"
  source_cidr_block   = ["${var.cidrs_private}"]
}

module "redis_mono_production" {
  source = "../../modules/oxa-elasticache/elasticache_redis"

  project     = "${var.project}"
  environment = "${var.env}"

  instance_name        = "llsrp-redismono-prod"
  instance_oxaname     = "${var.customer}.${var.region}-${var.project}.redis-mono-${var.env}"
  instance_type        = "${var.redis_instance_type}"
  instance_description = "myenterprise-redis-${var.env}"

  #automatic_failover_enabled = "${var.redis_automatic_failover_enabled}"
  automatic_failover_enabled = "false"

  #desired_clusters           = "${var.redis_desired_clusters}"
  desired_clusters = "1"

  engine_version = "${var.redis_engine_version}"

  #parameter_group = "${var.redis_parameter_group}"
  parameter_group = "default.redis3.2"

  security_group_ids = "${module.redis-in_production.security_group_id}"
  subnet_ids         = ["${module.subnets-production.private_subnets_id}"]
}

# Output the Configuration Endpoint of the ElastiCache Instance
output "redis_mono_production_configuration_endpoint" {
  value = "${join(",", module.redis_mono_production.configuration_endpoint)}:6379"
}

# Output the Endpoint of the ElastiCache Instance
output "redis_mono_production_endpoint" {
  value = "${join(",", module.redis_mono_production.endpoint)}:6379"
}
