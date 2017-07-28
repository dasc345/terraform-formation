# Module Terraform oxa-network

Ce module Terraform est obligatoire sur toutes les infrastructures AWS gérées par Oxalide.
Il crée un VPC, une connexion VPN et assure le(s) VPC peering vers le(s) VPC Oxalide.
La liste des VPCs Oxalide est disponible [ici](https://synapse.oxalide.net/display/DT/Liste+des+ID+des+VPC+Peering).

## Usage ##

```
module "oxa-network" {
  source                  = "git::ssh://git@oxalide.factory.git-01.adm/terraform/oxa-network.git"

  cust_vpc_name           = "vpc-${var.customer}"
  cust_vpc_cidr_block     = "${var.cust_vpc_cidr_block}"
  suffix_vpn              = "production"

  oxa_vpc_dns_support     = true
  oxa_vpc_dns_hostnames   = true

}
```


Outputs
=======

 - `main_route_table_assoc_id` - ID of the VPC's aws_main_route_table_association
 - `main_route_table_id` - The ID of the main route table associated with this VPC
