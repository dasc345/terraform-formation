variable "vpc_id" {}

variable "igw_id" {}

variable "name" {}

variable "environment" {}

variable "map_public_ip_on_launch" {
  default = false
}

variable "azs" {
  description = "A list of Availability zones in the region"
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  default     = []
}

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = []
}

variable "private_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  default     = []
}
