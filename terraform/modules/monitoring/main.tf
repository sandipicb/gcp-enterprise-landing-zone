resource "google_monitoring_notification_channel" "email" {
  type    = "email"
  display_name = "Operational Email "
  labels = {
    email_address = var.notification_email 
  }
  project = var.project_id 
} 
