resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-management"
  project = var.project_id
  network = var.network_name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["management"]

  allow {
    protocol = "tcp"
    ports    = ["22"]

  }

  description = "Allow SSH access to management instances"
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  project = var.project_id
  network = var.network_name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  description = "Allow HTTP traffic"
}

resource "google_compute_firewall" "allow_https" {
  name    = "allow-https"
  project = var.project_id
  network = var.network_name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  description = "Allow HTTPS traffic"
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  project = var.project_id
  network = var.network_name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [
    "10.10.0.0/24",
    "10.20.0.0/24",
    "10.30.0.0/24"
  ]

  allow {
    protocol = "all"
  }

  description = "Allow communication between internal subnets"
}
