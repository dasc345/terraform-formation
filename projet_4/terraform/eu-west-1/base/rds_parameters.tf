resource "aws_db_parameter_group" "parameter_group_56" {
  name        = "pg-mysql56"
  family      = "mysql5.6"
  description = "Parameter Group MySQL 5.6"

  parameter {
    name         = "query_cache_type"
    value        = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    name  = "group_concat_max_len"
    value = "4096"
  }

  parameter {
    name  = "innodb_thread_concurrency"
    value = "8"
  }

  parameter {
    name  = "log_output"
    value = "FILE"
  }

  parameter {
    name  = "query_cache_size"
    value = "134217728"
  }

  parameter {
    name  = "query_cache_limit"
    value = "16777216"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "table_open_cache"
    value = "10000"
  }

  parameter {
    name  = "innodb_lock_wait_timeout"
    value = "400"
  }

  parameter {
    name  = "sort_buffer_size"
    value = "1048576"
  }

  parameter {
    name  = "read_buffer_size"
    value = "1048576"
  }

  parameter {
    name  = "join_buffer_size"
    value = "1048576"
  }

  parameter {
    name  = "key_buffer_size"
    value = "134217728"
  }

  parameter {
    name  = "time_zone"
    value = "Europe/Paris"
  }
}
