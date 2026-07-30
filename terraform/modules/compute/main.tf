resource "google_compute_instance" "vm" {
  name         = var.instance_name
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type

  tags = var.tags

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-12"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork

    dynamic "access_config" {
      for_each = var.public_ip ? [1] : []
      content {}
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  service_account {
    email = var.service_account_email

    scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }


  allow_stopping_for_update = true
}
