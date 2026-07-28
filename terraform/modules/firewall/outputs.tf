output "firewall_rules" {
  description = "Firewall rule names"

  value = [
    google_compute_firewall.allow_ssh.name,
    google_compute_firewall.allow_http.name,
    google_compute_firewall.allow_https.name,
    google_compute_firewall.allow_internal.name
  ]
}