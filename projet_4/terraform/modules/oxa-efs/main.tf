# EFS
resource "aws_efs_file_system" "efs" {
  creation_token   = "${format("%s-%s-efs-%s", var.customer, var.region, var.service)}"
  performance_mode = "${var.performance_mode}"

  tags {
    Name             = "${format("%s.aws-%s.efs.%s", var.customer, var.region, var.service)}"
    Project          = "${var.project}"
    Environment      = "${var.environment}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxa-efs"
  }
}

# Security Group EC2
resource "aws_security_group" "ec2" {
  #name        = "${format("%s-%s-efs-ec2-%s", var.customer, var.region, var.service)}"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name             = "${format("%s.aws-%s.ec2-out.%s", var.customer, var.region, var.service)}"
    Project          = "${var.project}"
    Environment      = "${var.environment}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxa-efs"
  }
}

# Security Group MNT
resource "aws_security_group" "mnt" {
  #name        = "${format("%s-%s-efs-mnt-%s", var.customer, var.region, var.service)}"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name             = "${format("%s.aws-%s.nfs-in.%s", var.customer, var.region, var.service)}"
    Project          = "${var.project}"
    Environment      = "${var.environment}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxa-efs"
  }
}

resource "aws_security_group_rule" "ssh-in" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ec2.id}"
}

# Rules
#resource "aws_security_group_rule" "nfs-out" {
#  type                     = "egress"
#  from_port                = 2049
#  to_port                  = 2049
#  protocol                 = "tcp"
#  security_group_id        = "${aws_security_group.ec2.id}"
#  source_security_group_id = "${aws_security_group.mnt.id}"
#}

# Rules
resource "aws_security_group_rule" "nfs-in" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.mnt.id}"
  source_security_group_id = "${aws_security_group.ec2.id}"
}

resource "aws_efs_mount_target" "efs" {
  count = "${var.efs_subnet_count}"

  file_system_id = "${aws_efs_file_system.efs.id}"
  subnet_id      = "${element(var.efs_subnet_ids, count.index)}"

  security_groups = [
    "${aws_security_group.mnt.id}",
  ]
}
