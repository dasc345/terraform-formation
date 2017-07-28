resource "aws_cloudwatch_metric_alarm" "memcached_instance_cpuutilization" {
  alarm_name          = "${format("alarmCPUUtilization_%s_MemcachedCacheCluster_%s_%02d", var.environment, var.instance_name, (count.index + 1))}"
  alarm_description   = "Memcached instance CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.alarm_cpu_threshold}"

  dimensions {
    CacheClusterId = "${lower(var.instance_name)}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}

resource "aws_cloudwatch_metric_alarm" "memcached_instance_ramutilization" {
  alarm_name          = "${format("alarmMemcachedCacheClusterFreeableMemory_%s_MemcachedCacheCluster_%s_%02d", var.environment, var.instance_name, (count.index + 1))}"
  alarm_description   = "Memcached cluster freeable memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/ElastiCache"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.alarm_memory_threshold_bytes}"

  dimensions {
    CacheClusterId = "${lower(var.instance_name)}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}

variable "alarm_memory_threshold_bytes" {
  # 10MB
  default = "10000000"
}
