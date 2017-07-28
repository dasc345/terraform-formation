# Private Outputs
output "private_subnets_id" {
  value = ["${aws_subnet.private.*.id}"]
}

/*
 * output "private_subnets_id_list" {
 *   value = "${join(",", aws_subnet.private.*.id)}"
 * }
 */

output "private_cidrs_block" {
  value = ["${aws_subnet.private.*.cidr_block}"]
}

output "private_route_table_id" {
  value = ["${aws_route_table.private.*.id}"]
}

# Public Outputs
output "public_subnets_id" {
  value = ["${aws_subnet.public.*.id}"]
}

output "public_cidrs_block" {
  value = ["${aws_subnet.public.*.cidr_block}"]
}

output "public_route_table_id" {
  value = "${aws_route_table.public.id}"
}

output "nat_gateway_public_ips" {
  value = ["${aws_nat_gateway.public.*.public_ip}"]
}
