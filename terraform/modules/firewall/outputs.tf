output "firewall_rules" {
  description = "Firewall rule names"

  value = [
    google_compute_firewall.allow_internal.name,
    google_compute_firewall.allow_ssh_private.name,
    google_compute_firewall.allow_iap_ssh.name,
    google_compute_firewall.allow_lb_health_check.name
  ]
}
