data "terraform_remote_state" "base_state" {
  backend = "s3"

  config {
    bucket = "${var.tf_s3_bucket}"
    region = "${var.region}"
    key    = "${var.base_state_file}"
  }
}

data "terraform_remote_state" "production_state" {
  backend = "s3"

  config {
    bucket = "${var.tf_s3_bucket}"
    region = "${var.region}"
    key    = "${var.prod_state_file}"
  }
}
