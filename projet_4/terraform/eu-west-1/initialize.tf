## declare all the env-specific variables that are defined in *.tfvars

variable "env" {}

/* subnets */
variable "cidrs_private" {
  type = "list"
}

variable "cidrs_public" {
  type = "list"
}

/* RDS */
variable "rds_instance_class" {}

variable "rds_storage_type" {}
variable "rds_allocated_storage" {}
variable "rds_backup_retention" {}
variable "rds_engine_type" {}
variable "rds_engine_version" {}
variable "rds_is_multi_az" {}
variable "rds_database_name" {}
variable "rds_database_user" {}
variable "rds_database_password" {}

/* Redis */
variable "redis_automatic_failover_enabled" {}

variable "redis_instance_type" {}
variable "redis_desired_clusters" {}
variable "redis_engine_version" {}
variable "redis_parameter_group" {}

/* Backend */
variable "backend_ec2_type" {}

/* Cache */
variable "cache_ec2_type" {}
