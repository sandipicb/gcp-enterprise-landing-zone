output "router_name" {
  description = "Name of the Cloud Router"
  value       = google_compute_router.router.name
}

output "router_self_link" {
  description = "Self link of the Cloud Router"
  value       = google_compute_router.router.self_link
}