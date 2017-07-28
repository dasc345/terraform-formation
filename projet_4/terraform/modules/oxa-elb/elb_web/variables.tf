/*
 * Module: oxa-elb/elb_web
 */

/*
 * Module specific variables
 */

variable "elb_name" {}
variable "elb_oxaname" {}

variable "elb_is_internal" {
  description = "Determines if the ELB is internal or not"
  default     = false

  # Defaults to false, which results in an external IP for the ELB
}

variable "elb_security_group" {
  type = "list"
}

variable "backend_port" {
  description = "The port on the instance to route to"
  default     = "443"
}

variable "backend_protocol" {
  description = "The protocol to use to the instance"
  default     = "https"
}

variable "health_check_target" {
  description = "The URL the ELB should use for health checks"

  /* This is primarily used with `http` or `https` backend protocols
  * The format is like `HTTPS:443/health`
  */
}

variable "elb_subnet_ids" {
  type        = "list"
  description = "A list of instance ids to place in the ELB pool"
}

variable "elb_instance_ids" {
  type        = "list"
  description = "A list of instance ids to place in the ELB pool"
}

# See README.md for details on finding the
# ARN of an SSL certificate in EC2
variable "ssl_certificate_id" {
  description = "The ARN of the SSL Certificate in EC2"
}

variable "notification_period" {
  type        = "string"
  description = "Refer to Centreon Notification Period"
  default     = "onboarding"
}
