/*
 * This variables must be defined
 */
variable "customer" {
  description = "Customer's name"
  type        = "string"
}

variable "project" {
  description = "Project's name"
  type        = "string"
}

variable "bucket" {
  description = "S3 Bucket to use"
  type        = "string"
}

variable "environment" {
  description = "Environment name: production, staging, devel, ..."
  type        = "string"
}

variable "region" {
  description = "AWS Region where this EC2 is created"
  type        = "string"
}

variable "ec2_subnet_ids" {
  description = "Subnet's id where EC2 are created by ASG"
  type        = "list"
}

/*
 * At least one of these must be defined
 */
variable "git_ref" {
  description = "Chef's repo git reference to use"
  type        = "string"
  default     = ""
}

variable "ami" {
  description = "AMI's ID for launched EC2"
  type        = "string"
  default     = ""
}

/*
 * This variable can be overrided
 */

variable "ec2_type" {
  description = "EC2 instance type"
  type        = "string"
  default     = "t2.micro"
}

variable "vol_root_size" {
  description = "Size of /dev/sda mounted in /"
  type        = "string"
  default     = "20"
}

variable "vol_root_type" {
  description = "Type of volume for /"
  type        = "string"
  default     = "gp2"
}

variable "ec2_security_groups" {
  description = "List of AWS Security Groups protecting these EC2"
  type        = "list"
  default     = []
}

variable "cooldown" {
  description = "Cooldown timer for ASG"
  type        = "string"
  default     = "300"
}

variable "scaling_adjustment_up" {
  description = "Number of instances to add"
  type        = "string"
  default     = "1"
}

variable "scaling_adjustment_down" {
  description = "Number of instances to remove"
  type        = "string"
  default     = "-1"
}

variable "asg_min_size" {
  description = "Min Number of instances"
  type        = "string"
  default     = "2"
}

variable "asg_max_size" {
  description = "Max Number of instances"
  type        = "string"
  default     = "4"
}

variable "comparison_operator_up" {
  description = "Operator for ASG Threshold for adding instance"
  type        = "string"
  default     = "GreaterThanOrEqualToThreshold"
}

variable "comparison_operator_down" {
  description = "Operator for ASG Threshold for removing instance"
  type        = "string"
  default     = "LessThanOrEqualToThreshold"
}

variable "metric_name" {
  description = "Metric's name for Cloudwatch"
  type        = "string"
  default     = "CPUUtilization"
}

variable "namespace" {
  description = "Metric's namespace for Cloudwatch"
  type        = "string"
  default     = "AWS/EC2"
}

variable "period" {
  description = "Cloudwatch evaluation period"
  type        = "string"
  default     = "120"
}

variable "statistic" {
  description = "Cloudwatch computing method"
  type        = "string"
  default     = "Average"
}

variable "threshold_up" {
  description = "Threshold to activate upscaling policy"
  type        = "string"
  default     = "70"
}

variable "threshold_down" {
  description = "Threshold to activate downscaling policy"
  type        = "string"
  default     = "40"
}

variable "evaluation_periods_up" {
  description = "CloudWatch compares a window of $evalutation_period data points"
  type        = "string"
  default     = "1"
}

variable "evaluation_periods_down" {
  description = "CloudWatch compares a window of $evalutation_period data points"
  type        = "string"
  default     = "2"
}

variable "adjustment_type" {
  description = "ASG capacity adjustment type"
  type        = "string"
  default     = "ChangeInCapacity"
}

variable "health_check_grace_period" {
  description = "HealthCheck ASG Grace"
  type        = "string"
  default     = "300"
}

variable "health_check_type" {
  description = "HealthCheck Type for ASG"
  type        = "string"
  default     = "EC2"
}

variable "termination_policies" {
  description = "Policie for teminating Instances"
  type        = "string"
  default     = "OldestLaunchConfiguration"
}

variable "target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group "
  type        = "list"
  default     = []
}

variable "enabled_metrics" {
  description = "CloudWatch enabled metric"
  type        = "list"
  default     = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

variable "roles" {
  description = "IAM role for launched EC2s"
  type        = "list"
  default     = []
}

variable "load_balancers" {
  description = "Name of the ELBs in front of ASG"
  type        = "list"
  default     = []
}
