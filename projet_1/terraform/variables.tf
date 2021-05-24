variable "base_cidr_block" {
  default = "10.0.0.0/12"
}


# variable "azs" { }

variable "entity_name" {
  type = string
  default = "XXX"
}

variable "owner_name" {
  type = string
  default = "dasc345"
}

variable "env" {
  type = string
  default = "TEST"
}