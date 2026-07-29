resource "google_compute_address" "nat_ip" {
  name    = "${var.nat_name}-ip"
  project = var.project_id
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name    = var.nat_name
  project = var.project_id
  region  = var.region
  router  = var.router_name

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = [google_compute_address.nat_ip.self_link]

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

