resource "aws_cloudwatch_metric_alarm" "rds_instance_cpuutilization" {
  alarm_name          = "${format("alarmCPUUtilization_%s_RDSInstance_%s_%02d", var.environment, var.instance_name, (count.index + 1))}"
  alarm_description   = "RDS instance CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.alarm_cpu_threshold}"

  dimensions {
    DBInstanceIdentifier = "${var.instance_name}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}

resource "aws_cloudwatch_metric_alarm" "rds_instance_storagespace" {
  alarm_name          = "${format("alarmFreeStorageSpace_%s_RDSInstance_%s_%02d", var.environment, var.instance_name, (count.index + 1))}"
  alarm_description   = "RDS instance Free Storage Space"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.allocated_storage * 0.1}"

  dimensions {
    DBInstanceIdentifier = "${var.instance_name}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}
