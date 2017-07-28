/*
 * Module: oxa-elb/elb_ssl
 */

/*
 * Module specific variables
 */

variable "elb_name" {}

variable "elb_security_group" {}

variable "elb_is_internal" {
  description = "Determines if the ELB is internal or not"
  default     = false

  // Defaults to false, which results in an external IP for the ELB
}

variable "subnet_az_ids" {
  description = "The subnets for AZ"
  type        = "list"
}

variable "frontend_port" {
  description = "The port the service to listens on"
  type        = "string"
}

variable "backend_port" {
  description = "The port the service on the EC2 instances listens on"
  type        = "string"
}

variable "elb_subnet_ids" {
  type        = "list"
  description = "A list of instance ids to place in the ELB pool"
}

variable "elb_instance_ids" {
  type        = "list"
  description = "A list of instance ids to place in the ELB pool"
}

variable "notification_period" {
  type        = "string"
  description = "Refer to Centreon Notification Period"
  default     = "onboarding"
}
