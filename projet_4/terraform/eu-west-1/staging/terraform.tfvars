env = "staging"

cidrs_public                = [
  "10.133.146.0/25",
  "10.133.147.0/25",
]

cidrs_private               = [
  "10.133.146.128/25",
  "10.133.147.128/25",
]

rds_instance_class          = "db.m3.medium"
rds_storage_type            = "gp2"
rds_allocated_storage       = "50"
rds_backup_retention        = "7"
rds_engine_type             = "mysql"
rds_engine_version          = "5.6.29"
rds_is_multi_az             = "false"
rds_database_name           = "mydb"
rds_database_user           = "mydbuser"
rds_database_password       = "password"

redis_automatic_failover_enabled = "false"
redis_instance_type         = "cache.t2.small"
redis_desired_clusters      = "1"
redis_engine_version        = "3.2.4"
redis_parameter_group       = "default.redis3.2"

# backend_ec2_type            = "t2.medium"
backend_ec2_type            = "c3.large"

# cache_ec2_type              = "t2.small"
cache_ec2_type              = "c3.large"
