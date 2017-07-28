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

variable "environment" {
  description = "Environment name : production, staging, devel, ..."
  type        = "string"
}

variable "service" {
  description = "Service or features hosted by this EC2"
  type        = "string"
}

variable "autooff" {
  description = "Disable or Enable auto stop/start"
  type        = "string"
  default     = "False"
}

variable "region" {
  description = "AWS Region where this EC2 is created"
  type        = "string"
}

variable "az" {
  description = "AWS Region where this EC2 is created"
  type        = "list"
}

variable "ec2_image_id" {
  description = "AMI's id used as root"
  type        = "string"
}

variable "ec2_subnet_ids" {
  description = "Subnet's id where this EC2 is created"
  type        = "list"
}

variable "ec2_subnet_cidrs" {
  description = "Subnet's CIDR where this EC2 is created"
  type        = "list"
}

variable "ec2_hostnum_start" {
  description = "Starting position of the EC2's IP address in used subnet"
  type        = "string"
}

variable "ec2_key_name" {
  description = "SSH public key to deploy"
  type        = "string"
}

variable "ec2_security_group" {
  description = "List of AWS Security Group protecting this EC2"
  type        = "list"
}

/*
 * This variable can be overrided
 */

variable "number_of_ec2" {
  description = "Number of identical EC2 you want to create cross all specified AZ"
  default     = "1"
}

variable "ec2_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "vol_root_size" {
  description = "Size of /dev/sda mounted in /"
  default     = "20"
}

variable "vol_root_type" {
  description = "Type of volume for /"
  default     = "gp2"
}

variable "vol_space_size" {
  description = "Size of volume for /"
  default     = "20"
}

variable "vol_space_type" {
  description = "Type of volume for /space"
  default     = "gp2"
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
