//
// Module: oxa-elasticache_redis
//

// Output the ID of the ElastiCache Instance
output "instance_id" {
  value = ["${aws_elasticache_replication_group.redis_instance.*.id}"]
}

// Output the Port of the ElastiCache Instance
output "port" {
  value = "6379"
}

// Output the Configuration Endpoint of the ElastiCache Instance
output "configuration_endpoint" {
  value = ["${aws_elasticache_replication_group.redis_instance.*.configuration_endpoint_address}"]
}

// Output the Endpoint of the ElastiCache Instance
output "endpoint" {
  value = ["${aws_elasticache_replication_group.redis_instance.*.primary_endpoint_address}"]
}
