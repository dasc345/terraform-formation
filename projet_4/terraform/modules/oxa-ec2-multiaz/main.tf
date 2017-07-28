# EC2 INSTANCE
resource "aws_instance" "ec2" {
  count = "${var.number_of_ec2}"

  ami           = "${var.ec2_image_id}"
  instance_type = "${var.ec2_type}"
  key_name      = "${var.ec2_key_name}"

  associate_public_ip_address = false

  private_ip = "${cidrhost(element(var.ec2_subnet_cidrs, (count.index % length(var.az))), (var.ec2_hostnum_start + ((count.index / length(var.az)))))}"
  subnet_id  = "${element(var.ec2_subnet_ids, count.index)}"

  vpc_security_group_ids = ["${var.ec2_security_group}"]

  root_block_device {
    volume_size           = "${var.vol_root_size}"
    volume_type           = "${var.vol_root_type}"
    delete_on_termination = false
  }

  tags {
    Name = "${
        format(
          "%s.aws-%s.%s-%02d%s", 
          var.customer,
          var.region,
          var.service, 
          ( ( count.index / length(var.az) )  + 1 ),
          element( split("", element(var.az, (count.index % length(var.az)))) , (length(split("", element(var.az, (count.index % length(var.az))))) - 1 ))
        )}"

    Project          = "${var.project}"
    Environment      = "${var.environment}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxa-ec2-multiaz"
    autoOff          = "${var.autooff}"
  }
}
