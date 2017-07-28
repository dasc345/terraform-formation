/*
 * Output ID of sg_https_only SG created
 */
output "security_group_id_web" {
  value = "${aws_security_group.https_only.id}"
}
