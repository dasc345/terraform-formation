//
// Module: oxa-elasticache_redis
//

// ElastiCache Instance Variables
variable "project" {}

variable "environment" {}

variable "instance_name" {}

variable "instance_oxaname" {}

variable "instance_description" {}

variable "parameter_group" {}

/*
   *Set default to "default.redis3.2.cluster.on" when redis_desired_cluster is superior to "1"
   *
   *Options available : default.redis3.2.cluster.on, default.redis3.2
   */

variable "subnet_ids" {
  type = "list"
}

variable "security_group_ids" {}

variable "desired_clusters" {}

/*
   *Set default to "true" when redis_desired_cluster is superior to "1"
   *
   *Automatic failover is not supported for T1 and T2 cache node types
   */

variable "instance_type" {}

variable "engine_version" {}

variable "automatic_failover_enabled" {}

variable "alarm_cpu_threshold" {
  description = "Threshold for CPU Utilization Alarm Trigger"
  default     = "80"
}

variable "alarm_actions" {
  description = "The list of actions to execute when alarm is triggered (ARN)."
  type        = "list"
  default     = []
}
