//
// Module: oxa-elasticache_redis
//

// ElastiCache Subnet Group
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name        = "${var.instance_name}subnetgroup"
  description = "Redis subnet group"
  subnet_ids  = ["${var.subnet_ids}"]
}

// ElastiCache Instance
resource "aws_elasticache_replication_group" "redis_instance" {
  depends_on                    = ["aws_elasticache_subnet_group.redis_subnet_group"]
  replication_group_id          = "${lower(var.instance_name)}"
  replication_group_description = "${var.instance_description}"
  automatic_failover_enabled    = "${var.automatic_failover_enabled}"
  number_cache_clusters         = "${var.desired_clusters}"
  node_type                     = "${var.instance_type}"
  engine_version                = "${var.engine_version}"
  parameter_group_name          = "${var.parameter_group}"
  security_group_ids            = ["${var.security_group_ids}"]
  subnet_group_name             = "${aws_elasticache_subnet_group.redis_subnet_group.name}"
  port                          = "6379"

  tags {
    Project          = "${var.project}"
    Environment      = "${var.environment}"
    ManagementModule = "oxa-elasticache_redis"
    ManagementTool   = "Terraform"
    oxaname          = "${var.instance_oxaname}"
  }
}
