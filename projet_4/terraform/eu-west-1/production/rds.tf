/*
 * RDS Magento Database
 * Will host the database on RDS.
 */

module "rds-in_production" {
  source = "../../modules/oxa-security_groups/sg_rds"

  security_group_name = "rds-in_production"
  vpc_id              = "${data.terraform_remote_state.base_state.vpc_id}"

  source_cidr_block = [
    "${data.terraform_remote_state.staging_state.deploy_private_ip}",
    "${var.cidrs_private}",
  ]
}

module "rds_production" {
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

  security_group_ids = "${module.rds-in_production.security_group_id}"
  db_parameter_group = "${data.terraform_remote_state.base_state.rds_parameter_group_56_name}"

  subnet_ids  = "${module.subnets-production.private_subnets_id}"
  is_multi_az = "${var.rds_is_multi_az}"
}

# Output the Endpoint of the RDS Instance
output "rds_production_instance_endpoint" {
  value = "${join(",", module.rds_production.instance_endpoint)}"
}

# Output the Backup Retention of the RDS Instance
output "rds_production_backup_retention" {
  value = "${join(",", module.rds_production.backup_retention)}"
}
