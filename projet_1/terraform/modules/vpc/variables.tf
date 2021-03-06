variable "region" {
  description = "The name of the AWS region to set up a network within"
}

variable "base_cidr_block" {}


variable "vpc_name" {
  type = string
}

variable "igw_name" {
  type = string
  default = "test"
}

variable "owner_name" {}

variable "env" {
  type = string
}

variable "region_numbers" {
  default = {
    us-east-1    = 1
    us-west-1    = 2
    eu-central-1 = 3
    eu-west-1    = 4
  }
}

variable "az_numbers" {
  default = {
    a = 1
    b = 2
    c = 3
    d = 4
    e = 5
    f = 6
    g = 7
    h = 8
    i = 9
    j = 10
    k = 11
    l = 12
    m = 13
    n = 14
  }
}