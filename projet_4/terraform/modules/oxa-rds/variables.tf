//
// Module: oxa-rds
//

// RDS Instance Variables
variable "project" {}

variable "environment" {}

variable "instance_name" {}

variable "instance_oxaname" {}

variable "is_multi_az" {}

/*
   *Set default to false to disable multi-az
   */

variable "storage_type" {}

/*
   *See http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html for more details
   */

variable "backup_retention" {}

variable "allocated_storage" {}

/*
   *See http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#Concepts.Storage.GeneralSSD for more details
   */

variable "engine_type" {}

variable "engine_version" {}

/*
   *See http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html for more details
   */

variable "instance_class" {}

/*
   *See http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html for more details
   */

variable "database_name" {}

variable "database_user" {}

variable "database_password" {}

variable "security_group_ids" {}

variable "db_parameter_group" {}

// RDS Subnet Group Variables
variable "subnet_ids" {
  type = "list"
}

variable "alarm_cpu_threshold" {
  description = "Threshold for CPU Utilization Alarm Trigger"
  default     = "80"
}

variable "alarm_actions" {
  description = "The list of actions to execute when alarm is triggered (ARN)."
  type        = "list"
  default     = []
}
