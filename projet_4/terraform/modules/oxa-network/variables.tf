# vim:set expandtab tabstop=2 shiftwidth=2:

variable "cust_vpc_cidr_block" {}

variable "suffix_vpn" {
  default = ""
}

variable "cust_vpc_name" {
  default = "customer-vpc"
}

variable "oxa_vpc_dns_support" {
  description = "Whether or not the VPC has DNS support"
  default     = true
}

variable "oxa_vpc_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  default     = true
}
