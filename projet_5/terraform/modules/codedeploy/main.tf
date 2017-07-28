resource "aws_codedeploy_app" "codedeploy_app" {
    name = "${var.name}"
}

resource "aws_iam_role" "codedeploy_iam_role" {
  name = "role-codedeploy-${var.name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
    "Statement": [
      {
          "Action": "sts:AssumeRole",
          "Principal": {
              "Service": "codedeploy.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
      }
    ]
}
EOF
}

resource "aws_iam_role_policy" "codedeploy_iam_policy" {
    name = "policy-codedeploy-${var.name}"
    role = "${aws_iam_role.codedeploy_iam_role.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:CompleteLifecycleAction",
                "autoscaling:DeleteLifecycleHook",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeLifecycleHooks",
                "autoscaling:PutLifecycleHook",
                "autoscaling:RecordLifecycleActionHeartbeat",
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceStatus",
                "tag:GetTags",
                "tag:GetResources"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
