output "managed_zone_name" {
  value = google_dns_managed_zone.zone.name
}

output "managed_zone_dns_name" {
  value = google_dns_managed_zone.zone.dns_name
}

output "name_servers" {
  value = google_dns_managed_zone.zone.name_servers
}
