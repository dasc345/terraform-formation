data "aws_ami" "debian_ami" {
  most_recent = true

  #executable_users = ["self"]

  filter {
    name   = "name"
    values = ["debian-jessie-amd64-hvm*"]
  }
  # name_regex = "^myami-\\d{3}"
  # This account ID is Debian official
  owners = ["379101102735"] # account ID, amazon, or self
}

resource "aws_instance" "terraform" {
  ami                  = "${data.aws_ami.debian_ami.image_id}"
  instance_type        = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.terraform_profile.name}"
  key_name             = "${aws_key_pair.deployer.key_name}"
  user_data            = "${file("userdata.sh")}"

  tags {
    Name      = "terraform-formation-lls-${var.student}"
    Trigramme = "${var.student}"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3V7heBO08FWLmrdA22H49I9LVnW4drpKRFSQEprtyFu7ovjnf7OX4ZO1Opi2NMghI5/Fmyg9OAMbXclVY+bRbOWtvzm9d2eSfYoj5Y4m4aHr2jDD6tpiFBpVXoFE8Q/gedBEez3d4LV5R92JFU7p6wZScXc2tqpFwiBxbRTDK8cDXsv/ZwiiK3HMg4aTdDonAMeCbBHR/85hveCP/o+A9jRqY44pnuWQ7vUeu/YOah0VmWW4YqmsK56zJS88aw3MzyF41z5hed3wgxOAw3RgBVCTwqxGwRP9hVuSp7QXwzF1bKZk6YrMD/BM20OAsMC4s7N+KXmLeaUI/D2thlghB jboulanger@bastion-pa1-01"
}

output "ami" {
  value = "${data.aws_ami.debian_ami.image_id}"
}

output "aws_instance" {
  value = "${data.aws_ami.debian_ami.image_id}"
}
