output "instance_id" {
  description = "Compute instance ID."
  value       = google_compute_instance.vm.id
}

output "instance_name" {
  description = "Compute instance name."
  value       = google_compute_instance.vm.name
}

output "internal_ip" {
  description = "Internal IP address of the instance."
  value       = google_compute_instance.vm.network_interface[0].network_ip
}

output "self_link" {
  description = "Self-link of the compute instance."
  value       = google_compute_instance.vm.self_link
}
