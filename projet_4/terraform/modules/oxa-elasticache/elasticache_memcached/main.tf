//
// Module: oxa-elasticache_memcached
//

// ElastiCache Subnet Group
resource "aws_elasticache_subnet_group" "memcached_subnet_group" {
  name        = "${var.instance_name}subnetgroup"
  description = "Memcached subnet group"
  subnet_ids  = ["${var.subnet_ids}"]
}

// ElastiCache Instance
resource "aws_elasticache_cluster" "memcached_instance" {
  depends_on           = ["aws_elasticache_subnet_group.memcached_subnet_group"]
  cluster_id           = "${lower(var.instance_name)}"
  engine               = "memcached"
  engine_version       = "${var.engine_version}"
  node_type            = "${var.instance_type}"
  num_cache_nodes      = "${var.desired_clusters}"
  az_mode              = "${var.az_mode}"
  parameter_group_name = "${var.parameter_group}"
  security_group_ids   = ["${var.security_group_ids}"]
  subnet_group_name    = "${aws_elasticache_subnet_group.memcached_subnet_group.name}"
  port                 = "11211"

  tags {
    Project          = "${var.project}"
    Environment      = "${var.environment}"
    ManagementModule = "oxa-elasticache_memcached"
    ManagementTool   = "Terraform"
    oxaname          = "${var.instance_oxaname}"
  }
}
