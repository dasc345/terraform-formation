//
// Module: oxa-rds
//

// Output the ID of the RDS Instance
output "instance_id" {
  value = ["${aws_db_instance.rds_instance.*.id}"]
}

// Output the Address of the RDS Instance
output "instance_endpoint" {
  value = ["${aws_db_instance.rds_instance.*.endpoint}"]
}

output "backup_retention" {
  value = ["${aws_db_instance.rds_instance.*.backup_retention_period}"]
}

// Output the ID of the Subnet Group
output "subnet_group_id" {
  value = ["${aws_db_subnet_group.db_subnet_group.*.id}"]
}
