// Module specific variables
variable "security_group_name" {
  description = "The name for the security group"
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}

# To choose which rule to enable, override this map in your root variable
variable "enabled_rules" {
  description = "Map to enable rule accordingly to your need"
  type        = "map"

  default = {
    "default_allowed_tcp_port"       = true  # This rule enable singles tcp ports
    "default_allowed_udp_port"       = true  # This rule enable singles udp ports
    "default_allowed_tcp_port_range" = true  #
    "default_allowed_udp_port_range" = true
    "custom_allowed_tcp_ports"       = false
    "custom_allowed_udp_ports"       = false
    "allowed_icmp"                   = true
    "allow_out"                      = true
  }
}

variable "source_cidr_block_monitoring" {
  # Oxalide monitoring networks
  description = "The source CIDR block to allow traffic from"
  type        = "list"

  default = [
    "10.1.71.0/24",
    "10.200.0.0/16",
    "10.201.36.0/22",
    "10.202.0.0/16",
  ]
}

# Current

variable "default_allowed_tcp_ingress_ports" {
  description = "List of allowed TCP port"
  type        = "list"
  default     = ["80", "443", "9300", "8080", "5672", "15672"]
}

variable "default_allowed_udp_ingress_ports" {
  description = "List of allowed UDP port"
  type        = "list"
  default     = ["161", "123"]
}

# Copy this map to your root variable tf file and change the value according to
# your need, override enabled_rules to enable it
variable "custom_allowed_tcp_ingress_ports" {
  description = "List of allowed TCP port"
  type        = "list"
  default     = ["666"]
}

# Copy this map to your root variable tf file and change the value according to
# your need, override enabled_rules to enable it
variable "custom_allowed_udp_ingress_ports" {
  description = "List of allowed UDP port"
  type        = "list"
  default     = ["666"]
}

# Allow tcp port range. To disable this, override enabled_rules
variable "default_allowed_ingress_tcp_port_range" {
  type = "map"

  default = {
    "0" = "50,700"
    "1" = "103,190"
  }
}

variable "default_allowed_ingress_udp_port_range" {
  type = "map"

  default = {
    "0" = "50,700"
    "1" = "103,190"
  }
}
