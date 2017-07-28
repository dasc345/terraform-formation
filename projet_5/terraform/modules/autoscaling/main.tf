# Autoscaling
resource "aws_iam_instance_profile" "asg" {
  name  = "profile-${var.customer}-${var.project}-${var.environment}"
  roles = ["${aws_iam_role.asg.name}", "${var.roles}"]
}

resource "aws_iam_role" "asg" {
  name = "role-${var.customer}-${var.project}-${var.environment}"

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

resource "aws_iam_role_policy" "asg_policy" {
  name = "policy-${var.customer}-${var.project}-${var.environment}"
  role = "${aws_iam_role.asg.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Sid": "",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket}",
                "arn:aws:s3:::${var.bucket}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_launch_configuration" "asg" {
  name_prefix   = "lc-${var.customer}-${var.project}-${var.environment}-"
  image_id      = "${data.aws_ami.ami_to_use.id}"
  instance_type = "${var.ec2_type}"

  security_groups = [
    "${aws_security_group.asg_base_sg.id}",
    "${var.ec2_security_groups}",
  ]

  iam_instance_profile = "${aws_iam_instance_profile.asg.name}"

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_size = "${var.vol_root_size}"
    volume_type = "${var.vol_root_type}"
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "${var.customer}.aws-${var.region}.asg-${var.project}-${var.environment}"
  vpc_zone_identifier       = ["${var.ec2_subnet_ids}"]
  min_size                  = "${var.asg_min_size}"
  max_size                  = "${var.asg_max_size}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  launch_configuration      = "${aws_launch_configuration.asg.name}"
  load_balancers            = ["${var.load_balancers}"]
  termination_policies      = ["${var.termination_policies}"]
  target_group_arns         = ["${module.alb.my_target_group_arn_output}"]

  lifecycle {
    create_before_destroy = true
  }

  enabled_metrics = ["${var.enabled_metrics}"]

  tag {
    key                 = "Name"
    value               = "${var.customer}.aws-${var.region}.asg-${var.project}-${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "oxaname"
    value               = "${var.customer}.aws-${var.region}.asg-${var.project}-${var.environment}"
    propagate_at_launch = false
  }

  tag {
    key                 = "CodeDeployEnv"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "project"
    value               = "${var.project}"
    propagate_at_launch = true
  }
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch-alarm-up" {
  alarm_name          = "${aws_autoscaling_group.asg.name}-up"
  comparison_operator = "${var.comparison_operator_up}"
  evaluation_periods  = "${var.evaluation_periods_up}"
  metric_name         = "${var.metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.threshold_up}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.asg.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.asg-policy-01-up.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch-alarm-down" {
  alarm_name          = "${aws_autoscaling_group.asg.name}-down"
  comparison_operator = "${var.comparison_operator_down}"
  evaluation_periods  = "${var.evaluation_periods_down}"
  metric_name         = "${var.metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.threshold_down}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.asg.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.asg-policy-01-down.arn}"]
}

resource "aws_autoscaling_policy" "asg-policy-01-up" {
  name                   = "${aws_autoscaling_group.asg.name}-up"
  scaling_adjustment     = "${var.scaling_adjustment_up}"
  adjustment_type        = "${var.adjustment_type}"
  cooldown               = "${var.cooldown}"
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
}

resource "aws_autoscaling_policy" "asg-policy-01-down" {
  name                   = "${aws_autoscaling_group.asg.name}-down"
  scaling_adjustment     = "${var.scaling_adjustment_down}"
  adjustment_type        = "${var.adjustment_type}"
  cooldown               = "${var.cooldown}"
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
}

resource "aws_security_group" "asg_base_sg" {
  name        = "asg-base-sg-${var.customer}-${var.project}-${var.environment}"
  description = "Allow Oxalide administration traffic"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["10.255.0.0/16", "10.1.71.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "asg-base-sg-${var.customer}-${var.project}-${var.environment}"
    customer    = "${var.customer}"
    project     = "${var.project}"
    environment = "${var.environment}"
  }
}
