env = "production"

cidrs_public                = [
  "10.133.144.0/25",
  "10.133.145.0/25",
]

cidrs_private               = [
  "10.133.144.128/25",
  "10.133.145.128/25",
]

rds_instance_class          = "db.m3.xlarge"
rds_storage_type            = "gp2"
rds_allocated_storage       = "300"
rds_backup_retention        = "7"
rds_engine_type             = "mysql"
rds_engine_version          = "5.6.29"
rds_is_multi_az             = "true"
rds_database_name           = "mydb"
rds_database_user           = "mydbuser"
rds_database_password       = "9wyaAI2bRcA9"

redis_automatic_failover_enabled = "true"
redis_instance_type         = "cache.m3.medium"
redis_desired_clusters      = "2"
redis_engine_version        = "3.2.4"
redis_parameter_group       = "default.redis3.2.cluster.on"

backend_ec2_type            = "c4.4xlarge"

cache_ec2_type              = "r3.large"
