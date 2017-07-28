/*
 * Module specific variables
 */
variable "security_group_name" {
  description = "The name for the security group"
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}

variable "type" {
  description = "Declare the RDS instance type (mysql or postgres)"
  default     = "mysql"
}

variable "ports" {
  type = "map"

  default = {
    mysql    = "3306"
    postgres = "5432"
  }
}

variable "source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
  type        = "list"
  default     = ["0.0.0.0/0"]
}
