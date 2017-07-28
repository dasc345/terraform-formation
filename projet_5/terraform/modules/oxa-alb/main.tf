# Sort of "builtin SG for ALB", ingress is configured just below in aws_security_group_rule
resource "aws_security_group" "alb" {
  count = "${var.enable}"
  name  = "${format("%s-aws-%s-%s-alb_sg", var.customer, var.region, var.role)}"

  vpc_id = "${var.vpc_id}"

  tags {
    Name             = "${format("%s-aws-%s-%s-alb_sg", var.customer, var.region, var.role)}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxa-security_group//sg_alb"
  }
}

/* get this error : * aws_iam_policy.policy: Error creating IAM policy s3_alb_policy: MalformedPolicyDocument: Policy document should not specify a principal.
data "aws_iam_policy_document" "s3_alb_policy_doc" {

    statement {
        effect ="Allow"
        actions = [
            "s3:*",
        ]
        resources = [
            "arn:aws:s3:::${var.alb_name}-bucket/*",
        ]
        principals {
           type = "AWS"
           identifiers = ["arn:aws:iam::${lookup(var.alb_accouts, var.region)}:root"]
       }
    }
}

{
    "Version": "2012-10-17",
    "Id": "Policy1488553708042",
    "Statement": [
        {
            "Sid": "Stmt1488553706007",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::582318560864:root"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::lls-alb-v1-bucket/*"
        }
    ]
}

resource "aws_iam_policy" "policy" {
    name = "s3_alb_policy"
    path = "/"
    description = "Allow ALB to access bucket"
    policy = "${data.aws_iam_policy_document.s3_alb_policy_doc.json}"
}*/

// alb_listener_security_group_inbound adds a inbound security group rule to
// allow traffic into the ALB listener port.
resource "aws_security_group_rule" "alb_listener_security_group_inbound" {
  count             = "${var.enable ? length(var.alb_ports_ingress) : 0}"
  security_group_id = "${aws_security_group.alb.id}"
  from_port         = "${var.alb_ports_ingress[count.index]}"
  to_port           = "${var.alb_ports_ingress[count.index]}"
  type              = "ingress"
  protocol          = "tcp"
  cidr_blocks       = ["${var.alb_allowed_cidrs}"]
}

resource "aws_security_group_rule" "alb_listener_security_group_outbound" {
  count             = "${var.enable ? 1 : 0}"
  security_group_id = "${aws_security_group.alb.id}"
  from_port         = "${var.default_target_group_port}"
  to_port           = "${var.default_target_group_port}"
  type              = "egress"
  protocol          = "tcp"
  cidr_blocks       = ["${var.target_cidr_block}"]
}

/*resource "aws_s3_bucket" "alb_logs" {
  count  = "${var.enable ? 1 : 0}"
  bucket = "${var.alb_name}-bucket"
  acl    = "private"
  force_destroy = true

  tags {
    Name             = "${var.alb_name}-bucket"
    Environment      = "${var.env}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxa-security_group//sg_alb"
  }
}*/

# Make the link between
/*resource "aws_alb_target_group_attachment" "ec2_attach" {
  count            = "${length(var.alb_instance_ids)}"
  target_group_arn = "${aws_alb_target_group.alb_default_target_group.arn}"
  target_id        = "${element(var.alb_instance_ids, count.index)}"
  port             = "${var.default_target_group_port}"
}*/

# TODO: Doesn't work if number of EC2 instances doesn't change (may be triggers  key = "${uuid()}" will)
resource "null_resource" "alb_bug_workaround" {
  count = "${var.enable_registering ? 1 : 0}"

  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    #instance_ids = "${join(",", var.alb_instance_ids)}"
    key = "${uuid()}"
  }

  provisioner "local-exec" {
    command = "aws elbv2 register-targets --target-group-arn  ${aws_alb_target_group.alb_default_target_group.arn} --targets ${join(" ", formatlist("Id=%s", var.alb_instance_ids))}"
  }
}

# Create a new load balancer
resource "aws_alb" "alb" {
  count           = "${var.enable ? 1 : 0}"
  name            = "${format("%s-aws-%s-%s-alb", var.customer, var.region, var.role)}"
  internal        = "${var.alb_is_internal}"
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = ["${var.alb_subnet_ids}"]

  enable_deletion_protection = false

  access_logs {
    # TODO: create the bucket resources see line 78 resource "aws_s3_bucket" "alb_logs"
    # bucket = "${aws_s3_bucket.alb_logs.bucket}"
    bucket = "${format("%s-aws-%s-%s-alb-bucket", var.customer, var.region, var.role)}"

    # "folder" where log are stored
    prefix = "${var.env}"
  }

  tags {
    Environment      = "${var.env}"
    Name             = "${format("%s-aws-%s-%s-alb", var.customer, var.region, var.role)}"
    oxaname          = "${format("%s.aws-%s.%s-alb", var.customer, var.region, var.role)}"
    ManagementTool   = "Terraform"
    ManagementModule = "${format("%s//alb_%s", var.customer, var.project)}"
  }
}

resource "aws_alb_listener" "alb_https" {
  count             = "${var.enable && var.enable_ssl ? 1 : 0}"
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${var.listener_certificate_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_default_target_group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "alb_http" {
  count             = "${var.enable ? 1 : 0}"
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_default_target_group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "alb_default_target_group" {
  count    = "${var.enable ? 1 : 0}"
  name     = "default-target-${replace(aws_alb.alb.arn_suffix, "/.*\\/([a-z0-9]+)$/", "$1")}"
  port     = "${var.default_target_group_port}"
  protocol = "${var.default_target_group_protocol}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    path                = "${var.health_check_target}"
    interval            = 30
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400
    enabled         = false
  }

  tags {
    Environment      = "${var.env}"
    Name             = "${format("%s-aws-%s-%s-alb", var.customer, var.region, var.role)}"
    ManagementTool   = "Terraform"
    ManagementModule = "${format("%s//alb_%s", var.customer, var.project)}"
  }
}
