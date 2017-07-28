/*
 * Module: oxa-alb/alb_web
 */

/*
 * Module specific variables
 */

variable "customer" {}
variable "project" {}
variable "role" {}
variable "region" {}
variable "vpc_id" {}
variable "env" {}
variable "enable" {}

variable "enable_registering" {
  default = true
}

variable "enable_ssl" {
  description = "Enable HTTPS"
}

variable "target_cidr_block" {
  type    = "list"
  default = []
}

variable "alb_instance_ids" {
  type    = "list"
  default = []
}

#format("arn:aws:iam::%s:root", lookup(alb_accouts, var.region))

/*{
  "Id": "Policy1488549693527",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1488549688760",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::%s/*",
      "Principal": {
        "AWS": [
          "arn:aws:iam::%s:root"
        ]
      }
    }
  ]
}*/

variable "alb_accouts" {
  type = "map"

  default = {
    us-east-1      = "127311923021"
    us-east-2      = "033677994240"
    us-west-1      = "027434742980"
    us-west-2      = "797873946194"
    ca-central-1   = "985666609251"
    eu-west-1      = "156460612806"
    eu-central-1   = "054676820928"
    eu-west-2      = "652711504416"
    ap-northeast-1 = "582318560864"
    ap-northeast-2 = "600734575887"
    ap-southeast-1 = "114774131450"
    ap-southeast-2 = "783225319266"
    ap-south-1     = "718504428378"
    sa-east-1      = "507241528517"
  }
}

variable "alb_allowed_cidrs" {
  type    = "list"
  default = ["0.0.0.0/0"]
}

variable "alb_subnet_ids" {
  type        = "list"
  description = "A list of instance ids to place in the alb pool"
}

// module terraform_aws_alb

// If this is set to "true", the ALB will be private, and will not have an
// elastic IP assigned to it. The default is "false", which gives the ELB an
// elastic (public) IP.
variable "alb_is_internal" {
  default = false
}

// The external port that the ALB will listen to requests on.
variable "listener_port" {
  type    = "string"
  default = "80"
}

// The listener protocol. Can be one of HTTP or HTTPS.
variable "listener_protocol" {
  type    = "string"
  default = "HTTP"
}

// The ARN of the server certificate you want to use with the listener.
// Required for HTTPS listeners.
variable "listener_certificate_arn" {
  type    = "string"
  default = ""
}

// The port that the default target group will pass requests to.
variable "default_target_group_port" {
  type    = "string"
  default = "80"
}

variable "alb_ports_ingress" {
  type    = "list"
  default = ["80", "443"]
}

// The protocol for the default target group.
variable "default_target_group_protocol" {
  type    = "string"
  default = "HTTP"
}

variable "health_check_target" {
  type    = "string"
  default = "value"
}
