# CodeDeploy Terraform module

A Terraform module to manage AWS CodeDeploy. This is mainly used to manage
autoscaled infrastructures where we need to apply changes (Chef of application)
to ephemeral instances.

This is used by the [autoscaling module](https://gitlab.oxalide.net/terraform/autoscaling).

This modules creates the CodeDeploy application. You still have to manage the
[deployment groups](https://www.terraform.io/docs/providers/aws/r/codedeploy_deployment_group.html)
for the application. You can have several deployment groups for a single
application (one for production and one for preproduction for instance).

## Module Input Variables

* ``name``: the name of the CodeDeploy application you want.

## Outputs

 * ``app_name``: The application name,
 * ``deployer_role_arn``: The default IAM role to use for the deployment
groups of this application.

## Usage

```
module "mycodedeployapp" {
  source = "git::ssh://git@oxalide.factory.git-01.adm/terraform/codedeploy.git"

  name = "mysuperapp"
}

resource "aws_codedeploy_deployment_group" "myprodgroup" {
    app_name = "${module.mycodedeployapp.app_name}"
    deployment_group_name = "mygroupname"
    service_role_arn = "${module.mycodedeployapp.deployer_role_arn}"
    autoscaling_groups = ["${aws_autoscaling_group.myprodasg.id}"]
}

resource "aws_codedeploy_deployment_group" "mypreprodgroup" {
    app_name = "${module.mycodedeployapp.app_name}"
    deployment_group_name = "mygroupname"
    service_role_arn = "${module.mycodedeployapp.deployer_role_arn}"
    autoscaling_groups = ["${aws_autoscaling_group.mypreprodasg.id}"]
}
```

---

## Authors

Originally created and maintained for [Oxalide](http://www.oxalide.com/) by:
 * [Arnaud Bazin](https://gitlab.oxalide.net/arnaud.bazin)
 * [Nicolas Vion](https://gitlab.oxalide.net/nvion)
 * [Théo Chamley](https://gitlab.oxalide.net/theo.chamley)
