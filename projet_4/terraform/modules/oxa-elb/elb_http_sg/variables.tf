/*
 * Module: oxa-elb/elb_http_sg
 */

/*
 * Module specific variables
 */

variable "elb_name" {}
variable "vpc_id" {}

variable "elb_allowed_cidrs" {
  type    = "list"
  default = ["0.0.0.0/0"]
}

variable "elb_is_internal" {
  description = "Determines if the ELB is internal or not"
  default     = false

  # Defaults to false, which results in an external IP for the ELB
}

variable "backend_port" {
  description = "The port on the instance to route to"
  default     = "80"
}

variable "backend_protocol" {
  description = "The protocol to use to the instance"
  default     = "http"
}

variable "health_check_target" {
  description = "The URL the ELB should use for health checks"

  /* This is primarily used with `http` or `https` backend protocols
  * The format is like `HTTP:80/health`
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

variable "notification_period" {
  type        = "string"
  description = "Refer to Centreon Notification Period"
  default     = "onboarding"
}
