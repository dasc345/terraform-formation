/*
 * RDS Magento Database
 * Will host the database on RDS.
 */

module "rds-in_staging" {
  source = "../../modules/oxa-security_groups/sg_rds"

  security_group_name = "rds-in_staging"
  vpc_id              = "${data.terraform_remote_state.base_state.vpc_id}"

  source_cidr_block = [
    "${format("%s/32", element(module.deploy.ec2_private_ips, 0))}",
    "${var.cidrs_private}",
  ]
}

module "rds_staging" {
  source = "../../modules/oxa-rds"

  project     = "${var.project}"
  environment = "${var.env}"

  instance_name    = "rds-${var.env}"
  instance_oxaname = "${var.customer}.${var.region}-${var.project}.rds-${var.env}"
  instance_class   = "${var.rds_instance_class}"

  allocated_storage = "${var.rds_allocated_storage}"
  storage_type      = "${var.rds_storage_type}"

  backup_retention = "${var.rds_backup_retention}"

  engine_type    = "${var.rds_engine_type}"
  engine_version = "${var.rds_engine_version}"

  database_name     = "${var.rds_database_name}"
  database_user     = "${var.rds_database_user}"
  database_password = "${var.rds_database_password}"

  security_group_ids = "${module.rds-in_staging.security_group_id}"
  db_parameter_group = "${data.terraform_remote_state.base_state.rds_parameter_group_56_name}"

  #subnet_ids  = "${list(element(module.subnets-staging.private_subnets_id, 0))}"
  subnet_ids  = "${module.subnets-staging.private_subnets_id}"
  is_multi_az = "${var.rds_is_multi_az}"
}

# Output the Endpoint of the RDS Instance
output "rds_staging_instance_endpoint" {
  value = "${join(",", module.rds_staging.instance_endpoint)}"
}

# Output the Backup Retention of the RDS Instance
output "rds_staging_backup_retention" {
  value = "${join(",", module.rds_staging.backup_retention)}"
}
