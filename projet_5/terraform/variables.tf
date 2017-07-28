variable "region" {}

variable "project" {}

variable "client" {}

variable "env" {}

variable "front_type" {
  type = "map"

  default = {
    eu-central-1 = "t2.micro"
    eu-west-1    = "t2.micro"
  }
}

variable "bucket_chef" {
  type = "map"

  default = {
    eu-central-1 = "lls-api-chef-packages"
    eu-west-1    = "lls-api-chef-packages"
  }
}

variable "vpc_cidr_block_environment" {
  type    = "list"
  default = ["staging", "prod"]
}

variable "cust_vpc_cidr_block" {
  type = "map"

  default = {
    eu-central-1 = "10.133.176.0/22,10.133.24.0/22"
  }
}

# Base AMI to create ASG
variable "asg_ami" {
  description = "Template AMI"
  default     = "ami-ebc5c08d"
}

## WARNING: redis_parameters describes the ',' separeted list of redis_parameters_value
variable "asg_parameters" {
  type    = "list"
  default = ["min", "max"]
}

variable "asg_parameters_value" {
  type = "map"

  /*MIN,MAX*/
  default = {
    eu-central-1 = "2,4"
    eu-west-1    = "2,4"
  }
}

variable "map_public_ip_on_launch" {
  type = "map"

  default = {
    eu-west-1      = false
    eu-central-1   = true
  }
}


variable "enable_dynamic_azs" {
  type = "map"

  default = {
    eu-west-1      = true
    eu-central-1   = true
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}


variable "static_azs" {
  type = "map"

  default = {
    eu-central-1 = "eu-central-1a,eu-central-1c"
    eu-west-1 = "eu-west-1a,eu-west-1b"
  }
}


variable "alb_enable" {
  type = "map"

  default = {
    us-east-1      = false
    us-west-1      = false
    us-west-2      = false
    eu-west-1      = true
    eu-central-1   = false
    ap-northeast-1 = false
    ap-northeast-2 = false
    ap-southeast-1 = false
    ap-southeast-2 = false
    sa-east-1      = false
  }
}

variable "alb_enable_registering" {
  type = "map"

  default = {
    us-east-1      = false
    us-west-1      = false
    us-west-2      = false
    eu-west-1      = true
    eu-central-1   = false
    ap-northeast-1 = false
    ap-northeast-2 = false
    ap-southeast-1 = false
    ap-southeast-2 = false
    sa-east-1      = false
  }
}

variable "alb_asg_enable" {
  type = "map"

  default = {
    us-east-1      = false
    us-west-1      = false
    us-west-2      = false
    eu-west-1      = true
    eu-central-1   = false
    ap-northeast-1 = false
    ap-northeast-2 = false
    ap-southeast-1 = false
    ap-southeast-2 = false
    sa-east-1      = false
  }
}

variable "alb_asg_enable_registering" {
  type = "map"

  default = {
    eu-west-1    = false
    eu-central-1 = false
  }
}
