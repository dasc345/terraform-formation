resource "aws_cloudtrail" "oxalide" {
  name                       = "ct-llsformation-logs"
  s3_bucket_name             = "ct-llsformation-logs"
  is_multi_region_trail      = true
  enable_log_file_validation = true
}
