/**
 * monitor作成
 * https://www.terraform.io/docs/providers/datadog/r/monitor.html
 */

############################
# host                     #
############################
resource "datadog_monitor" "host" {
  name    = "Check Host datadog.agent.up status {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\ndatadog.agent.up status is down {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}}\n\n\n{{#is_recovery}}\n\ndatadog.agent.up status is up {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"datadog.agent.up\".over(\"*\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:host"
  ]
}

############################
# metric                   #
############################
resource "datadog_monitor" "cpu" {
  name    = "CPU load is very high on {{host.name}}"
  type    = "metric alert"
  message = "{{#is_alert}}\n\nCPU load is 80% on {{host.name}}\nhttps://app.datadoghq.com/dash/integration/system_overview?tpl_var_scope=host:{{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}}\n\n\n{{#is_alert_recovery}}\n\nCPU load is vack to normal to {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert_recovery}}\n\n\n{{#is_warning}}\n\nCPU load is 70% on {{host.name}}\nhttps://app.datadoghq.com/dash/integration/system_overview?tpl_var_scope=host:{{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_warning}}\n\n\n{{#is_warning_recovery}}\n\nCPU load is vack to normal to {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_warning_recovery}}"

  query   = "avg(last_5m):avg:system.cpu.idle{!server_type:macpro} by {host} < 20"

  thresholds {
    warning           = 30
    critical          = 20
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:cpu"
  ]
}

resource "datadog_monitor" "disk" {
  name    = "DISK use is very high on {{host.name}}"
  type    = "metric alert"
  message = "{{#is_alert}}\n\nDISK use is 80% on {{host.name}}\nhttps://app.datadoghq.com/dash/integration/system_overview?tpl_var_scope=host:{{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}}\n\n\n{{#is_alert_recovery}}\n\nDISK use is vack to normal to {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert_recovery}}\n\n\n{{#is_warning}}\n\nDISK use is 70% on {{host.name}}\nhttps://app.datadoghq.com/dash/integration/system_overview?tpl_var_scope=host:{{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_warning}}\n\n\n{{#is_warning_recovery}}\n\nDISK use is vack to normal to {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_warning_recovery}}"

  query   = "max(last_5m):avg:system.disk.in_use{!host:Sumzap-477} by {host,device} > 0.8"

  thresholds {
    warning           = 0.7
    critical          = 0.8
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:disk"
  ]
}

resource "datadog_monitor" "inode" {
  name    = "Inode use is very high on {{host.name}}"
  type    = "metric alert"
  message = "{{#is_alert}}\n\nInode use is 80% on {{host.name}}\nhttps://app.datadoghq.com/dash/integration/system_overview?tpl_var_scope=host:{{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}}\n\n\n{{#is_alert_recovery}}\n\nInode use is vack to normal to {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert_recovery}}\n\n\n{{#is_warning}}\n\nInode use is 70% on {{host.name}}\nhttps://app.datadoghq.com/dash/integration/system_overview?tpl_var_scope=host:{{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_warning}}\n\n\n{{#is_warning_recovery}}\n\nInode use is vack to normal to {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_warning_recovery}}"

  query   = "avg(last_5m):avg:system.fs.inodes.in_use{*} by {host} > 0.8"

  thresholds {
    warning           = 0.7
    critical          = 0.8
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:inode"
  ]
}

resource "datadog_monitor" "mysql_replication_behind" {
  name    = "Mysql Replication Behind {{host.name}}"
  type    = "metric alert"
  message = "{{#is_alert}}\n\nMysql Replication Behind 600s {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}}\n\n\n{{#is_alert_recovery}}\n\nReplication Behind was resolved {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert_recovery}}\n\n\n{{#is_warning}}\n\nMysql Replication Behind 300s {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_warning}}\n\n\n{{#is_warning_recovery}}\n\nReplication Behind was resolved {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_warning_recovery}}"

  query   = "avg(last_5m):avg:mysql.replication.seconds_behind_master{*} by {host} > 600"

  thresholds {
    warning           = 300
    critical          = 600
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:replication"
  ]
}

############################
# process                  #
############################
resource "datadog_monitor" "process_consul" {
  name    = "Check Process [consul] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [consul] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [consul] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:consul\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:consul"
  ]
}

resource "datadog_monitor" "process_docker" {
  name    = "Check Process [docker] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [docker] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [docker] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:docker\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = "1.1754943508222875e-38"
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:docker"
  ]
}

resource "datadog_monitor" "process_gitlab" {
  name    = "Check Process [gitlab] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [gitlab] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [gitlab] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:gitlab\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:gitlab"
  ]
}

resource "datadog_monitor" "process_haproxy" {
  name    = "Check Process [haproxy] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [haproxy] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [haproxy] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:haproxy\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:haproxy"
  ]
}

resource "datadog_monitor" "process_jenkins" {
  name    = "Check Process [jenkins] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [jenkins] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [jenkins] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:jenkins\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:jenkins"
  ]
}

resource "datadog_monitor" "process_mysqld" {
  name    = "Check Process [mysqld] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [mysqld] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [mysqld] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:mysqld\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:mysqld"
  ]
}

resource "datadog_monitor" "process_nginx" {
  name    = "Check Process [nginx] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [nginx] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [nginx] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:nginx\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:nginx"
  ]
}

resource "datadog_monitor" "process_ntpd" {
  name    = "Check Process [ntpd] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [ntpd] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [ntpd] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:ntpd\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:ntpd"
  ]
}

resource "datadog_monitor" "process_php-fpm" {
  name    = "Check Process [php-fpm] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [php-fpm] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [php-fpm] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:php-fpm\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:php-fpm"
  ]
}

resource "datadog_monitor" "process_postfix" {
  name    = "Check Process [postfix] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [postfix] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [postfix] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:postfix\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:postfix"
  ]
}

resource "datadog_monitor" "process_redis" {
  name    = "Check Process [redis] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [redis] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [redis] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:redis\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:redis"
  ]
}

resource "datadog_monitor" "process_rsyslogd" {
  name    = "Check Process [rsyslogd] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [rsyslogd] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [rsyslogd] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:rsyslogd\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:rsyslogd"
  ]
}

resource "datadog_monitor" "process_sshd" {
  name    = "Check Process [sshd] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [sshd] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [sshd] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:sshd\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:sshd"
  ]
}

resource "datadog_monitor" "process_swagger" {
  name    = "Check Process [swagger] {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching processes [swagger] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}} \n\n\n{{#is_recovery}}\n\nFound matching processes [swagger] {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"process.up\".over(\"process:swagger\").by(\"host\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:process",
    "service:swagger"
  ]
}

############################
# network                  #
############################
resource "datadog_monitor" "tcp_port" {
  name    = "Check TCP Port {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nNot Found matching port {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}}\n\n\n{{#is_recovery}}\n\nFound matching port {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"tcp.can_connect\".over(\"*\").by(\"host\",\"port\").last(1).pct_by_status()"

  thresholds {
    warning           = 0
    critical          = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:port"
  ]
}

############################
# その他                    #
############################
resource "datadog_monitor" "ntp" {
  name    = "Clock in sync with NTP {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nTriggers if any host's clock goes out of sync with the time given by NTP. The offset threshold is configured in the Agent's `ntp.yaml` file.\n\nPlease read the [KB article](http://help.datadoghq.com/hc/en-us/articles/204282095-Network-Time-Protocol-NTP-Offset-Issues) on NTP Offset issues for more details on cause and resolution.\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}}\n\n\n{{#is_recovery}}\n\nSync NTP {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"ntp.in_sync\".over(\"*\").by(\"host\").last(2).count_by_status()"

  thresholds {
    warning           = 1
    critical          = 1
    ok                = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:ntp"
  ]
}

resource "datadog_monitor" "agent_status" {
  name    = "Check datadog agent status {{host.name}}"
  type    = "service check"
  message = "{{#is_alert}}\n\nDatadog agent is not running {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_alert}}\n\n\n{{#is_recovery}}\n\nDatadog agent is running {{host.name}}\n\n{{#is_match \"host.env\" \"dev\"}} @slack-bayguh-dev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"lod\"}} @slack-bayguh-lod-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"rev\"}} @slack-bayguh-rev-alert {{/is_match}}\n\n{{#is_match \"host.env\" \"shd\"}} @slack-bayguh-shd-alert {{/is_match}}\n\n{{/is_recovery}}"

  query   = "\"datadog.agent.check_status\".over(\"*\").by(\"host\").last(1).count_by_status()"

  thresholds {
    warning           = 1
    critical          = 1
    ok                = 1
  }

  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  no_data_timeframe   = 2
  renotify_interval   = 0
  include_tags        = true

  tags = [
    "service:agent"
  ]
}
