//
// Module: oxa-elasticache_memcached
//

// ElastiCache Instance Variables
variable "project" {}

variable "environment" {}

variable "instance_name" {}

variable "instance_oxaname" {}

variable "parameter_group" {}

variable "subnet_ids" {
  type = "list"
}

variable "security_group_ids" {}

variable "desired_clusters" {}

/*
   *If memcached_az_mode is set to cross-az, memcached_desired_clusters should be at least set to "2"
   */

variable "az_mode" {}

/*
   *Options available : single-az, cross-az
   *
   *Set default to single-az to disable multi-az
   */

variable "instance_type" {}

variable "engine_version" {}

variable "alarm_cpu_threshold" {
  description = "Threshold for CPU Utilization Alarm Trigger"
  default     = "80"
}

variable "alarm_actions" {
  description = "The list of actions to execute when alarm is triggered (ARN)."
  type        = "list"
  default     = []
}
