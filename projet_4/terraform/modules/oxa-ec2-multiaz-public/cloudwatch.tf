resource "aws_cloudwatch_metric_alarm" "ec2_instance_cpuutilization" {
  count               = "${var.number_of_ec2}"
  alarm_name          = "${format("alarmCPUUtilization_%s_Ec2Instance_%s_%02d", var.environment, var.service, (count.index + 1))}"
  alarm_description   = "EC2 instance CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.alarm_cpu_threshold}"

  dimensions {
    InstanceId = "${element(aws_instance.ec2.*.id, count.index)}"
  }

  #	alarm_actions = ["${aws_sns_topic.cloudwatch_alerts.arn}"]
  alarm_actions = ["${var.alarm_actions}"]
}
