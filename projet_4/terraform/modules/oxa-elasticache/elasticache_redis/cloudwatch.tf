resource "aws_cloudwatch_metric_alarm" "redis_instance_cpuutilization" {
  count               = "${var.desired_clusters}"
  alarm_name          = "${format("alarmCPUUtilization_%s_redisCacheCluster_%s_%02d", var.environment, var.instance_name, (count.index + 1))}"
  alarm_description   = "redis instance CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.alarm_cpu_threshold}"

  dimensions {
    CacheClusterId = "${aws_elasticache_replication_group.redis_instance.id}-0001-00${count.index + 1}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}

resource "aws_cloudwatch_metric_alarm" "redis_instance_ramutilization" {
  count               = "${var.desired_clusters}"
  alarm_name          = "${format("alarmredisCacheClusterFreeableMemory_%s_redisCacheCluster_%s_%02d", var.environment, var.instance_name, (count.index + 1))}"
  alarm_description   = "redis cluster freeable memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/ElastiCache"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.alarm_memory_threshold_bytes}"

  dimensions {
    CacheClusterId = "${aws_elasticache_replication_group.redis_instance.id}-0001-00${count.index + 1}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}

variable "alarm_memory_threshold_bytes" {
  # 10MB
  default = "10000000"
}
