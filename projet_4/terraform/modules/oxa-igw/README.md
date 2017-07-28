Internet Gateway Terraform module
=================================

A Terraform module to provide an Internet Gateway in AWS.


Module Input Variables
----------------------

- `vpc_id` - VPC id
- `name` - Name (optional)

Usage
-----

```js
module "igw" {
  source = "git::https://gitlab.oxalide.net/terraform/oxa-igw"

  name   = "default"
  vpc_id = "${module.oxa-network.vpc_id}"
}
```

Outputs
=======

 - `igw_id` - IGW id

Sources
=======

[terraform-community-modules / tf_aws_igw](https://github.com/terraform-community-modules/tf_aws_igw)

Authors
=======

Originally created and maintained by [Anton Babenko](https://github.com/antonbabenko)

License
=======

Apache 2 Licensed. See LICENSE for full details.
