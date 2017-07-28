output "sg_ssh_from_deploy_id" {
  value = "${module.ssh-from-deploy.security_group_id}"
}

output "deploy_private_ip" {
  value = "${format("%s/32", element(module.deploy.ec2_private_ips, 0))}"
}
