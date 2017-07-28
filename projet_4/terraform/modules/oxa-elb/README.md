oxa-elb
=======

A Terraform module which contains a number of common configurations for AWS ELBs.
* It assumes you're putting your backend instances for the ELBs in a VPC.

ELB Catalog
-----------

This modules contains the following ELB templates for you to use as modules in
service Terraform templates.

ELB without automatic Security Group creation
---------------------------------------------

- [elb_https](https://gitlab.oxalide.net/terraform/oxa-elb/tree/master/elb_https) - This template will create an ELB setup to serve HTTPS traffic.
    - Defaults to external but can be made internal by setting the `elb_in_internal` variable to `true`
    - We recommend you use this with the [sg_https_only](https://gitlab.oxalide.net/terraform/oxa-security_groups/tree/master/sg_https_only) security group module
- [elb_http](https://gitlab.oxalide.net/terraform/oxa-elb/tree/master/elb_http) - This template will create an ELB setup to serve HTTP (TCP 80) traffic.
    - Defaults to external but can be made internal by setting the `elb_in_internal` variable to `true`
- [elb_tcp](https://gitlab.oxalide.net/terraform/oxa-elb/tree/master/elb_tcp) - This template will create an ELB setup to serve HTTP (TCP 80) traffic.
    - Defaults to external but can be made internal by setting the `elb_in_internal` variable to `true`
    - You can use branch `elb_tcp_multi_listener` on this module for making proxy pass on port 80 and 443 to privates EC2 --> add `?ref=elb_tcp_listener` on module call
- [elb_ssl](https://gitlab.oxalide.net/terraform/oxa-elb/tree/master/elb_ssl) - This template will create an ELB setup to serve HTTPS traffic.
    - Defaults to external but can be made internal by setting the `elb_in_internal` variable to `true`
    - We recommend you use this with the [sg_https_only](https://gitlab.oxalide.net/terraform/oxa-security_groups/tree/master/sg_https_only) security group module


ELB with automatic Security Group creation
------------------------------------------

- [elb_http_sg](https://gitlab.oxalide.net/terraform/oxa-elb/tree/master/elb_http_sg)  
    - This template will create an ELB setup to serve HTTP (TCP 80) traffic.
    - Defaults to external but can be made internal by setting the `elb_in_internal` variable to `true`
    - It creates the associated Security Group

- [elb_https_sg](https://gitlab.oxalide.net/terraform/oxa-elb/tree/master/elb_https_sg)  
    - This template will create an ELB setup to serve HTTPS (TCP 443) traffic.
    - Defaults to external but can be made internal by setting the `elb_in_internal` variable to `true`
    - It creates the associated Security Group

- [elb_web_sg](https://gitlab.oxalide.net/terraform/oxa-elb/tree/master/elb_web_sg)  
    - This template will create an ELB setup to serve HTTP and HTTPS (TCP 80 and 443) traffic.
    - Defaults to external but can be made internal by setting the `elb_in_internal` variable to `true`
    - Traffic is routed to EC2 on port HTTP/80 (SSL Offloading) 
    - It creates the associated Security Group


Usage
------

- See individual module README's for Usage examples.

Authors
=======

Inspired by [Terraform Community Module](https://github.com/terraform-community-modules/tf_aws_elb).  
Created and maintained by [Brandon Burton](https://github.com/solarce) (brandon@inatree.org).  

Forked by [Oxalide](http://www.oxalide.com) during Initiative Week.  


License
=======

Apache 2 Licensed. See LICENSE for full details.
