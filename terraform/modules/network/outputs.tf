output "network_id" {
  description = "ID of the VPC network"
  value       = google_compute_network.vpc.id
}

output "network_name" {
  description = "Name of the VPC network"
  value       = google_compute_network.vpc.name
}

output "subnets" {
  description = "Created subnet details"

  value = {
    for name, subnet in google_compute_subnetwork.subnets :
    name => {
      name      = subnet.name
      region    = subnet.region
      cidr      = subnet.ip_cidr_range
      self_link = subnet.self_link
    }
  }
}
