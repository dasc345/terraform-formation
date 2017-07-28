//
// Module: oxa-elasticache_memcached
//

// Output the ID of the ElastiCache Instance
output "instance_id" {
  value = ["${aws_elasticache_cluster.memcached_instance.*.id}"]
}

// Output the Port of the ElastiCache Instance
output "port" {
  value = "11211"
}

// Output the Configuration Endpoint of the ElastiCache Instance
output "configuration_endpoint" {
  value = ["${aws_elasticache_cluster.memcached_instance.*.configuration_endpoint}"]
}

// Output the Endpoint of the ElastiCache Instance
output "endpoint" {
  value = ["${aws_elasticache_cluster.memcached_instance.*.cluster_address}"]
}
