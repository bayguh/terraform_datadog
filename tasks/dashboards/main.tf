/**
 * dashboard作成
 * https://www.terraform.io/docs/providers/datadog/r/timeboard.html
 */

############################
# timeboard                #
############################
resource "datadog_timeboard" "default_instance_timeboard" {
  title       = "Default Instance Timeboard"
  description = "created using the Datadog provider in Terraform"
  read_only   = false

  graph {
    title       = "UPTIME"
    viz         = "query_value"
    autoscale   = true
    precision   = "2"

    request {
      q                   = "avg:system.uptime{$env,$server_type,$host} by {host}"
      aggregator          = "avg"
      type                = "null"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Load Averages 1-5-15"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.load.1{$env,$server_type,$host} by {host}"
      type                = "line"
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }

    request {
      q                   = "avg:system.load.5{$env,$server_type,$host} by {host}"
      type                = "line"
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }

    request {
      q                   = "avg:system.load.15{$env,$server_type,$host} by {host}"
      type                = "line"
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "CPU usage (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "max:system.cpu.idle{$env,$server_type,$host} by {host}, max:system.cpu.user{$env,$server_type,$host} by {host}, max:system.cpu.system{$env,$server_type,$host} by {host}, max:system.cpu.iowait{$env,$server_type,$host} by {host}, max:system.cpu.stolen{$env,$server_type,$host} by {host}, max:system.cpu.guest{$env,$server_type,$host} by {host}"
      aggregator          = "avg"
      type                = "area"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Process usage CPU (%)"
    viz         = "toplist"
    autoscale   = true

    request {
      q                   = "top(avg:system.processes.cpu.pct{$env,$server_type,$host} by {process_name}, 5, 'mean', 'desc')"
      conditional_format  = []
      style {
        palette = "dog_classic"
      }
    }
  }

  graph {
    title       = "Memory breakdown"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.mem.total{$env,$server_type,$host} by {host}"
      aggregator          = "avg"
      type                = "area"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }

    request {
      q                   = "avg:system.mem.used{$env,$server_type,$host} by {host}"
      aggregator          = "avg"
      type                = "area"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Process usage Memory (%)"
    viz         = "toplist"
    autoscale   = true

    request {
      q                   = "top(avg:system.processes.mem.pct{$env,$server_type,$host} by {process_name}, 5, 'mean', 'desc')"
      conditional_format  = []
      style {
        palette = "dog_classic"
      }
    }
  }

  graph {
    title       = "Disk usage by device"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.disk.total{$env,$server_type,$host,$device} by {host,device}"
      aggregator          = "avg"
      type                = "area"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }

    request {
      q                   = "avg:system.disk.used{$env,$server_type,$host,$device} by {host,device}"
      type                = "area"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Disk usage by device (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "max:system.disk.in_use{$env,$server_type,$host,$device} by {host,device}*100"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Disk IO (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:gcp.gce.instance.disk.read_bytes_count{$env,$server_type,$host,$device} by {host}.as_count()"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }

    request {
      q                   = "avg:gcp.gce.instance.disk.write_bytes_count{$env,$server_type,$host,$device} by {host}.as_count()"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Network traffic (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.net.bytes_sent{$env,$server_type,$host} by {host}"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }

    request {
      q                   = "avg:system.net.bytes_rcvd{$env,$server_type,$host} by {host}"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  template_variable {
    default = "*"
    prefix  = "env"
    name    = "env"
  }

  template_variable {
    default = "*"
    prefix  = "server_type"
    name    = "server_type"
  }

  template_variable {
    default = "*"
    prefix  = "host"
    name    = "host"
  }

  template_variable {
    default = "*"
    prefix  = "device"
    name    = "device"
  }
}

resource "datadog_timeboard" "web_instance_timeboard" {
  title       = "Web Instance Timeboard"
  description = "created using the Datadog provider in Terraform"
  read_only   = false

  graph {
    title       = "Nginx connections"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:nginx.net.connections{$env,$server_type,$host} by {host}"
      type                = "line"
      aggregator          = "avg"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Nginx request (per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:nginx.net.request_per_s{$env,$server_type,$host} by {host}"
      type                = "line"
      aggregator          = "avg"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "php-fpm process count"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:php_fpm.processes.total{$env,$server_type,$host} by {host}"
      type                = "line"
      aggregator          = "avg"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title                   = "Running Instance"
    viz                     = "hostmap"
    autoscale               = false
    include_no_metric_hosts = true
    include_ungrouped_hosts = true

    request {
      q    = "avg:gcp.gce.instance.is_running{$env,$server_type,$host} by {host}"
      type = "fill"
    }

    style {
      palette      = "green_to_orange"
      palette_flip = "false"
    }

    scope = [
      "$env",
      "$server_type",
      "$host"
    ]
  }

  graph {
    title       = "Load Averages 5"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.load.5{$env,$server_type,$host} by {host}"
      type                = "line"
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "CPU usage (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.cpu.user{$env,$server_type,$host} by {host}"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Memory usage (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.mem.used{$env,$server_type,$host} by {host}/avg:system.mem.total{$env,$server_type,$host} by {host}*100"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Disk usage by device (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.disk.used{$env,$server_type,$host,$device} by {host,device}/avg:system.disk.total{$env,$server_type,$host,$device} by {host,device}*100"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Disk Read (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:gcp.gce.instance.disk.read_bytes_count{$env,$server_type,$host} by {host}.as_count()"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Disk Write (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:gcp.gce.instance.disk.write_bytes_count{$env,$server_type,$host} by {host}.as_count()"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Network traffic sent (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.net.bytes_sent{$env,$server_type,$host} by {host}"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Network traffic received (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.net.bytes_rcvd{$env,$server_type,$host} by {host}"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  template_variable {
    default = "*"
    prefix  = "env"
    name    = "env"
  }

  template_variable {
    default = "web"
    prefix  = "server_type"
    name    = "server_type"
  }

  template_variable {
    default = "*"
    prefix  = "host"
    name    = "host"
  }

  template_variable {
    default = "*"
    prefix  = "device"
    name    = "device"
  }
}

resource "datadog_timeboard" "db_instance_timeboard" {
  title       = "DB Instance Timeboard"
  description = "created using the Datadog provider in Terraform"
  read_only   = false

  graph {
    title       = "Innodb Read (per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:mysql.innodb.data_reads{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Innodb Write (per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:mysql.innodb.data_writes{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Query select (per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:mysql.performance.com_select{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Query update (per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:mysql.performance.com_update{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Mysql threads connectioned"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:mysql.performance.threads_connected{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Mysql slow queries"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:mysql.performance.slow_queries{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Innodb Buffer Pool usage (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:mysql.innodb.buffer_pool_used{$env,$server_type,$host} by {host}/avg:mysql.innodb.buffer_pool_total{$env,$server_type,$host} by {host}*100"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Innodb row lock time"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:mysql.innodb.row_lock_time{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Mysql replication behind master"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:mysql.replication.seconds_behind_master{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title                   = "Running Instance"
    viz                     = "hostmap"
    autoscale               = false
    include_no_metric_hosts = true
    include_ungrouped_hosts = true

    request {
      q    = "avg:gcp.gce.instance.is_running{$env,$server_type,$host} by {host}"
      type = "fill"
    }

    style {
      palette      = "green_to_orange"
      palette_flip = "false"
    }

    scope = [
      "$env",
      "$server_type",
      "$host"
    ]
  }

  graph {
    title       = "Load Averages 5"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.load.5{$env,$server_type,$host} by {host}"
      type                = "line"
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "CPU usage (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.cpu.user{$env,$server_type,$host} by {host}"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Memory usage (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.mem.used{$env,$server_type,$host} by {host}/avg:system.mem.total{$env,$server_type,$host} by {host}*100"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Disk usage by device (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.disk.used{$env,$server_type,$host,$device} by {host,device}/avg:system.disk.total{$env,$server_type,$host,$device} by {host,device}*100"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Disk Read (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:gcp.gce.instance.disk.read_bytes_count{$env,$server_type,$host} by {host}.as_count()"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Disk Write (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:gcp.gce.instance.disk.write_bytes_count{$env,$server_type,$host} by {host}.as_count()"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Network traffic sent (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.net.bytes_sent{$env,$server_type,$host} by {host}"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Network traffic received (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.net.bytes_rcvd{$env,$server_type,$host} by {host}"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  template_variable {
    default = "*"
    prefix  = "env"
    name    = "env"
  }

  template_variable {
    default = "mysql"
    prefix  = "server_type"
    name    = "server_type"
  }

  template_variable {
    default = "*"
    prefix  = "host"
    name    = "host"
  }

  template_variable {
    default = "*"
    prefix  = "device"
    name    = "device"
  }
}

resource "datadog_timeboard" "redis_instance_timeboard" {
  title       = "Redis Instance Timeboard"
  description = "created using the Datadog provider in Terraform"
  read_only   = false

  graph {
    title       = "Redis keys"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:redis.keys{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Redis memory used"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:redis.mem.used{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Redis expire keys"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:redis.expires{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Redis expire keys (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:redis.expires.percent{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Redis commands"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                  = "avg:redis.net.commands{$env,$server_type,$host} by {host}"
      type               = "line"
      aggregator         = "avg"
      conditional_format = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title                   = "Running Instance"
    viz                     = "hostmap"
    autoscale               = false
    include_no_metric_hosts = true
    include_ungrouped_hosts = true

    request {
      q    = "avg:gcp.gce.instance.is_running{$env,$server_type,$host} by {host}"
      type = "fill"
    }

    style {
      palette      = "green_to_orange"
      palette_flip = "false"
    }

    scope = [
      "$env",
      "$server_type",
      "$host"
    ]
  }

  graph {
    title       = "Load Averages 5"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.load.5{$env,$server_type,$host} by {host}"
      type                = "line"
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "CPU usage (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.cpu.user{$env,$server_type,$host} by {host}"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Memory usage (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.mem.used{$env,$server_type,$host} by {host}/avg:system.mem.total{$env,$server_type,$host} by {host}*100"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Disk usage by device (%)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.disk.used{$env,$server_type,$host,$device} by {host,device}/avg:system.disk.total{$env,$server_type,$host,$device} by {host,device}*100"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Disk Read (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:gcp.gce.instance.disk.read_bytes_count{$env,$server_type,$host} by {host}.as_count()"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Disk Write (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:gcp.gce.instance.disk.write_bytes_count{$env,$server_type,$host} by {host}.as_count()"
      aggregator          = "avg"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Network traffic sent (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.net.bytes_sent{$env,$server_type,$host} by {host}"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  graph {
    title       = "Network traffic received (bytes per sec)"
    viz         = "timeseries"
    autoscale   = true

    request {
      q                   = "avg:system.net.bytes_rcvd{$env,$server_type,$host} by {host}"
      type                = "line"
      conditional_format  = []
      style {
        width   = "normal"
        palette = "dog_classic"
        type    = "solid"
      }
    }
  }

  template_variable {
    default = "*"
    prefix  = "env"
    name    = "env"
  }

  template_variable {
    default = "redis"
    prefix  = "server_type"
    name    = "server_type"
  }

  template_variable {
    default = "*"
    prefix  = "host"
    name    = "host"
  }

  template_variable {
    default = "*"
    prefix  = "device"
    name    = "device"
  }
}
