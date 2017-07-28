variable "customer" {
  description = "Customer's name"
  type        = "string"
}

variable "project" {
  description = "Project's name"
  type        = "string"
}

variable "environment" {
  description = "Environment name : production, staging, devel, ..."
  type        = "string"
}

variable "service" {
  description = "Service or features using this EFS volume"
  type        = "string"
}

variable "region" {
  description = "AWS Region where this EC2 is created"
  type        = "string"
}

variable "vpc_id" {
  type        = "string"
  description = "(Required) The VPC ID where NFS security groups will be."
}

variable "efs_subnet_count" {
  description = "(Required) Number of subnet"
}

variable "efs_subnet_ids" {
  type        = "list"
  description = "(Required) A comma separated list of subnet ids where mount targets will be."
}

variable "performance_mode" {
  type        = "string"
  description = "(Optional) The file system performance mode. Can be either -generalPurpose- or -maxIO-"
  default     = "generalPurpose"
}
