/*
 * VPC
 */
variable "vpc_dns_support" {
  default = true
}

variable "vpc_dns_hostnames" {
  default = true
}

variable "cust_vpc_cidr_block" {
  default = "10.133.144.0/22"
}
