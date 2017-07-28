// Output ID of sg_monitoring SG we made
output "security_group_id" {
  value = "${aws_security_group.monitoring.id}"
}
