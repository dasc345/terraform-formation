resource "aws_iam_instance_profile" "terraform_profile" {
  name = "terraform_profile"
  role = "${aws_iam_role.role.name}"
}

resource "aws_iam_role" "role" {
  name = "ec2-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "terraform_create_policy-attach" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "${aws_iam_policy.terraform_create_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "terraform_delete_policy-attach" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "${aws_iam_policy.terraform_delete_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "terraform_read_policy-attach" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "${aws_iam_policy.terraform_read_policy.arn}"
}

resource "aws_iam_policy" "terraform_create_policy" {
  name   = "terraform_create_policy"
  path   = "/"
  policy = "${data.aws_iam_policy_document.terraform_create_policy.json}"
}

data "aws_iam_policy_document" "terraform_create_policy" {
  statement {
    sid = "1"

    actions = [
      "ec2:CreateNetworkAcl",
      "ec2:CreateNetworkAclEntry",
      "ec2:CreateNetworkInterface",
      "ec2:AttachNetworkInterface",
      "autoscaling:AttachLoadbalancers",
      "autoscaling:CreateAutoScalingGroup",
      "autoscaling:CreateLaunchConfiguration",
      "ec2:CreateVpc",
      "ec2:DescribeNetworkACLs",
      "ec2:DescribeRouteTables",
      "ec2:CreateVpc",
      "ec2:CreateVpcEndpoint",
      "ec2:CreateVpc",
      "ec2:CreateVpcPeeringConnection",
      "ec2:AcceptVpcPeeringConnection",
      "ec2:CreateSubnet",
      "ec2:CreateTags",
      "ec2:RunInstances",
      "ec2:MonitorInstances",
      "ec2:CreateSecurityGroup",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateInternetGateway",
      "ec2:AttachInternetGateway",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:EnableVGWRoutePropagation",
      "ec2:AllocateAddress",
      "ec2:AssociateAddress",
      "ec2:AssociateRouteTable",
      "route53:CreateHealthCheck",
      "ec2:CreateVolume",
      "ec2:AttachVolume",
      "elasticloadbalancing:ApplySecurityGroupsToLoadbalancer",
      "elasticloadbalancing:ConfigureHealthCheck",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateLoadBalancerListeners",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:AddTags",
      "iam:AddRoleToInstanceProfile",
      "iam:CreateInstanceProfile",
      "rds:AddTagsToResource",
      "iam:CreatePolicyVersion",
      "iam:PassRole",
    ]

    resources = [
      "*",
    ]
  }
}
