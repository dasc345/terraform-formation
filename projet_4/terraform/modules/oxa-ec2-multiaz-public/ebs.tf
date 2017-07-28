# EBS VOLUME
resource "aws_ebs_volume" "ebs" {
  count = "${var.number_of_ec2}"

  availability_zone = "${element(aws_instance.ec2.*.availability_zone, count.index)}"
  size              = "${var.vol_space_size}"
  type              = "${var.vol_space_type}"

  tags {
    Name = "${
        format(
          "%s.aws-%s.ebs.%s-%02d%s", 
          var.customer,
          var.region,
          var.service, 
          ( ( count.index / length(var.az) )  + 1 ),
          element( split("", element(var.az, (count.index % length(var.az)))) , (length(split("", element(var.az, (count.index % length(var.az))))) - 1 ))
        )}"

    Project          = "${var.project}"
    Environment      = "${var.environment}"
    ManagementModule = "oxa-ec2-multiaz-public"
    ManagementTool   = "Terraform"
  }

  #depends_on = ["element(aws_instance.ec2.*.id, count.index)"]
}

# VOLUME ATTACHEMENT
resource "aws_volume_attachment" "volume_attachment" {
  count = "${var.number_of_ec2}"

  device_name = "/dev/xvdb"

  volume_id   = "${element(aws_ebs_volume.ebs.*.id, count.index)}"
  instance_id = "${element(aws_instance.ec2.*.id, count.index)}"
}
