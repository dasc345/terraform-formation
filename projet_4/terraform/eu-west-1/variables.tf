variable "customer" {
  default = "myenterprise"
}

variable "project" {
  default = "mydomain"
}

variable "region" {
  default = "eu-central-1"
}

provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {}
}

variable "tf_s3_bucket" {
  default = "myenterprise-state"
}

variable "base_state_file" {
  default = "base.tfstate"
}

variable "prod_state_file" {
  default = "production.tfstate"
}

variable "staging_state_file" {
  default = "staging.tfstate"
}

variable "zones" {
  type = "list"

  default = [
    "eu-central-1a",
    "eu-central-1b",
  ]
}

variable "ami_id" {
  type    = "string"
  default = "ami-216eaf4e"
}
