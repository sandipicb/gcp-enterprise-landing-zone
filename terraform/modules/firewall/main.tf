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

resource "google_compute_firewall" "allow_ssh_private" {
  name    = "allow-ssh-private"
  project = var.project_id
  network = var.network_name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [
    "10.10.0.0/24"
  ]

  target_tags = ["private"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  description = "Allow SSH from management subnet to private instances"
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "allow-iap-ssh"
  project = var.project_id
  network = var.network_name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [
    "35.235.240.0/20"
  ]

  target_tags = ["private"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  description = "Allow IAP SSH access to private instances through IAP"
}

resource "google_compute_firewall" "allow_lb_health_check" {
  name    = "allow-lb-health-check"
  project = var.project_id
  network = var.network_name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]

  target_tags = ["private"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  description = "Allow Google Cloud Load Balancer health checks to private application instances"
}
