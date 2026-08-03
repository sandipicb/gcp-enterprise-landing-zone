variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "notification_email" {
  description = "Email address to monitoring alerts"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU utilization threshold"
  type        = number
  default     = 0.8
}

variable "alert_duration" {
  description = "How long the threshold must be exceeded before firing"
  type        = string
  default     = "300s"
}

variable "alignment_period" {
  description = "Metric alignment period"
  type        = string
  default     = "60s"
}

variable "dashboard_name" {
  description = "Monitoring dashboard name"
  type        = string
  default     = "Enterprise Landing Zone Dashboard"
}

variable "log_metric_name" {
  description = "Name of the log-based metric"
  type        = string
  default     = "vm-error-count"
}
