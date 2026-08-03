output "notification_channel" {
  value = google_monitoring_notification_channel.email.id
}

output "alert_policy" {
  value = google_monitoring_alert_policy.high_cpu.id
}

output "dashboard" {
  value = google_monitoring_dashboard.landing_zone_dashboard.id
}

output "log_metric_name" {
  description = "Name of the log-based metric"
  value       = google_logging_metric.vm_errors.name
}