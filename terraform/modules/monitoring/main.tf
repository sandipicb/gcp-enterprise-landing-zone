resource "google_monitoring_notification_channel" "email" {
  type         = "email"
  display_name = "Operational Email"
  labels = {
    email_address = var.notification_email
  }
  project = var.project_id
}

resource "google_monitoring_alert_policy" "high_cpu" {

  project      = var.project_id
  display_name = "High CPU Utilization"

  combiner = "OR"

  conditions {
    display_name = "CPU usage > 80%"
    condition_threshold {

      filter          = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
      comparison      = "COMPARISON_GT"
      threshold_value = var.cpu_threshold
      duration        = var.alert_duration

      aggregations {
        alignment_period   = var.alignment_period
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }
  notification_channels = [google_monitoring_notification_channel.email.id]
  enabled               = true

}

resource "google_monitoring_dashboard" "landing_zone_dashboard" {
  project = var.project_id
  dashboard_json = jsonencode({
    displayName = var.dashboard_name
    mosaicLayout = {
      columns = 12
      tiles = [
        {
          xPos   = 0
          yPos   = 0
          width  = 6
          height = 4

          widget = {
            title = "CPU utilization"

            xyChart = {
              dataSets = [
                {
                  plotType  = "LINE"
                  targetAxis = "Y1"

                  timeSeriesQuery = {
                    timeSeriesFilter = {
                      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
                    }
                  }
                }
              ]
            }

          }
        },
        {
          xPos   = 6
          yPos   = 0
          width  = 6
          height = 4

          widget = {
            title = "Network Received Bytes"

            xyChart = {
              dataSets = [
                {
                  plotType   = "LINE"
                  targetAxis = "Y1"

                  timeSeriesQuery = {
                    timeSeriesFilter = {
                      filter = "metric.type=\"compute.googleapis.com/instance/network/received_bytes_count\" AND resource.type=\"gce_instance\""
                    }
                  }
                }
              ]
            }

          }
        }
      ]
    }
  })
}

resource "google_logging_metric" "vm_errors" {

  project = var.project_id

  name        = var.log_metric_name
  description = "Counts ERROR and higher severity log entries from GCE instances"
  filter      = "resource.type=\"gce_instance\" AND severity>=ERROR"
  metric_descriptor {
    metric_kind  = "DELTA"
    value_type   = "INT64"
    display_name = "VM Error Count"
  }
}