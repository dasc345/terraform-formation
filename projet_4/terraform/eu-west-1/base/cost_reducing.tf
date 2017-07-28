# Policy
resource "aws_iam_policy" "ec2poweronoff" {
  name        = "${format("%s_ec2poweronoff", var.customer)}"
  path        = "/"
  description = "Policy to power off/on staging EC2"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "cloudwatch:*",
                "ec2:Describe*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
				"ec2:DescribeInstances",
				"ec2:DescribeImages",
				"ec2:DescribeKeyPairs",
				"ec2:DescribeSecurityGroups",
				"ec2:DescribeAvailabilityZones",
				"ec2:RunInstances",
				"ec2:TerminateInstances",
				"ec2:StopInstances",
				"ec2:StartInstances"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:ec2:eu-central-1:258307565614:instance/*"
        }
    ]
}
EOF
}

# User
resource "aws_iam_user" "ec2poweronoff" {
  name = "ec2poweronoff"
}

resource "aws_iam_access_key" "ec2poweronoff" {
  user = "${aws_iam_user.ec2poweronoff.name}"
}

resource "aws_iam_role" "ec2poweronoff" {
  name = "ec2poweronoff"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_group" "ec2poweronoff" {
  name = "ec2poweronoff"
}

resource "aws_iam_policy_attachment" "ec2poweronoff" {
  name = "ec2poweronoff"

  users = [
    "${aws_iam_user.ec2poweronoff.name}",
  ]

  roles      = ["${aws_iam_role.ec2poweronoff.name}"]
  groups     = ["${aws_iam_group.ec2poweronoff.name}"]
  policy_arn = "${aws_iam_policy.ec2poweronoff.arn}"
}

output "ec2poweronoff_ARN" {
  value = "${aws_iam_policy.ec2poweronoff.arn}"
}

output "ec2poweronoff_accesskey_id" {
  value = "${aws_iam_user.ec2poweronoff.unique_id}"
}

output "ec2poweronoff_secretkey" {
  value = "${aws_iam_access_key.ec2poweronoff.secret}"
}

#output "cdnuser01_secretkey" {
#  value = "${aws_iam_user.ec2poweronoff.secret}"
#}

