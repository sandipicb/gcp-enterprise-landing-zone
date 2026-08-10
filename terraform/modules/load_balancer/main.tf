resource "google_compute_health_check" "http" {
  name    = "enterprise-lb-health-check"
  project = var.project_id

  http_health_check {
    port         = 80
    request_path = "/"
  }

  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
}

resource "google_compute_instance_group" "app" {
  name    = "enterprise-lb-instance-group"
  project = var.project_id
  zone    = var.backend_zone

  instances = [
    "https://www.googleapis.com/compute/v1/projects/${var.project_id}/zones/${var.backend_zone}/instances/${var.backend_instance}"
  ]

  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_backend_service" "app" {
  name    = "enterprise-lb-backend-service"
  project = var.project_id

  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 30

  health_checks = [
    google_compute_health_check.http.id
  ]

  backend {
    group = google_compute_instance_group.app.self_link
  }
}

resource "google_compute_url_map" "http" {
  name    = "enterprise-lb-url-map"
  project = var.project_id

  default_service = google_compute_backend_service.app.id
}

resource "google_compute_target_http_proxy" "http" {
  name    = "enterprise-lb-http-proxy"
  project = var.project_id

  url_map = google_compute_url_map.http.id
}

resource "google_compute_global_forwarding_rule" "http" {
  name    = "enterprise-lb-forwarding-rule"
  project = var.project_id

  target = google_compute_target_http_proxy.http.id

  port_range = "80"

  ip_address = var.global_ip_address
}

resource "google_compute_managed_ssl_certificate" "app" {
  name    = "enterprise-lb-ssl-cert"
  project = var.project_id

  managed {
    domains = [var.domain]
  }

}

resource "google_compute_target_https_proxy" "https" {
  name    = "enterprise-lb-https-proxy"
  project = var.project_id

  url_map = google_compute_url_map.http.id

  ssl_certificates = [
    google_compute_managed_ssl_certificate.app.id
  ]
}

resource "google_compute_global_forwarding_rule" "https" {
  name    = "enterprise-lb-https-forwarding-rule"
  project = var.project_id

  target = google_compute_target_https_proxy.https.id

  port_range = "443"

  ip_address = var.global_ip_address

}