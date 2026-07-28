output "network_id" {
  value = google_compute_network.vpc.id
}

output "network_name" {
  description = "Name of the VPC network"
  value       = google_compute_network.vpc.name
}

output "subnets" {
  value = google_compute_subnetwork.subnets
}