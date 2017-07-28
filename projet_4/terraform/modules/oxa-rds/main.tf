//
// Module: oxa-rds
//

// RDS Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.instance_name}-subnet_group"
  description = "RDS subnet group"
  subnet_ids  = ["${var.subnet_ids}"]
}

// RDS Instance
resource "aws_db_instance" "rds_instance" {
  identifier              = "${var.instance_name}"
  allocated_storage       = "${var.allocated_storage}"
  engine                  = "${var.engine_type}"
  engine_version          = "${var.engine_version}"
  instance_class          = "${var.instance_class}"
  name                    = "${var.database_name}"
  username                = "${var.database_user}"
  password                = "${var.database_password}"
  vpc_security_group_ids  = ["${var.security_group_ids}"]
  db_subnet_group_name    = "${aws_db_subnet_group.db_subnet_group.name}"
  parameter_group_name    = "${var.db_parameter_group}"
  multi_az                = "${var.is_multi_az}"
  storage_type            = "${var.storage_type}"
  backup_retention_period = "${var.backup_retention}"

  tags {
    Project          = "${var.project}"
    Environment      = "${var.environment}"
    ManagementModule = "oxa-rds"
    ManagementTool   = "Terraform"
    oxaname          = "${var.instance_oxaname}"
  }
}
