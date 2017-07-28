output "ec2_instance_ids" {
  value = ["${aws_instance.ec2.*.id}"]
}

output "ec2_instance_names" {
  value = ["${aws_instance.ec2.*.tags.Name}"]
}

output "ec2_private_ips" {
  value = ["${aws_instance.ec2.*.private_ip}"]
}

output "ec2_instance_azs" {
  value = ["${aws_instance.ec2.*.availability_zone}"]
}

output "ec2_subnet_ids" {
  value = ["${aws_instance.ec2.*.subnet_id}"]
}

output "ec2_adm_records" {
  value = "${sort(formatlist(
      "%v    6000    IN    A    %v",
      aws_instance.ec2.*.tags.Name,
      aws_instance.ec2.*.private_ip
    ))}"
}
