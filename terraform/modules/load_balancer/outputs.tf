output "health_check_id" {
  description = "HTTP health check ID"
  value       = google_compute_health_check.http.id
}

output "backend_service_id" {
  description = "Backend service ID"
  value       = google_compute_backend_service.app.id
}

output "backend_service_name" {
  description = "Backend service name"
  value       = google_compute_backend_service.app.name
}

output "instance_group_name" {
  description = "Backend instance group name"
  value       = google_compute_instance_group.app.name
}