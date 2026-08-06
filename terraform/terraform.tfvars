project_id = "enterprise-landing-zone-504409"

region = "us-central1"

network_name = "enterprise-vpc"

zone = "us-central1-a"

storage_buckets = {

  "enterprise-landing-zone-504409-storage" = {

    location          = "US"
    storage_class     = "STANDARD"
    enable_versioning = true
    lifecycle_age     = 90
    force_destroy     = false


    labels = {
      environment = "lab"
      managed_by  = "terraform"
    }
  }

  "enterprise-landing-zone-504409-backups" = {

    location          = "US"
    storage_class     = "ARCHIVE"
    enable_versioning = true
    lifecycle_age     = 365
    force_destroy     = false

    labels = {
      environment = "lab"
      managed_by  = "terraform"
    }
  }

  "enterprise-landing-zone-504409-logs" = {

    location          = "US"
    storage_class     = "STANDARD"
    enable_versioning = true
    lifecycle_age     = 30
    force_destroy     = false

    labels = {
      environment = "lab"
      managed_by  = "terraform"
    }
  }

  "enterprise-landing-zone-504409-artifacts" = {

    location          = "US"
    storage_class     = "STANDARD"
    enable_versioning = true
    lifecycle_age     = 14
    force_destroy     = false

    labels = {
      environment = "lab"
      managed_by  = "terraform"
    }
  }
}

bucket_iam = {
  "enterprise-landing-zone-504409-storage" = [
    {
      role   = "roles/storage.objectAdmin"
      member = "serviceAccount:app-sa@enterprise-landing-zone-504409.iam.gserviceaccount.com"
    }
  ]
  "enterprise-landing-zone-504409-logs" = [
    {
      role   = "roles/storage.objectViewer"
      member = "serviceAccount:monitoring-sa@enterprise-landing-zone-504409.iam.gserviceaccount.com"
    }
  ]
  "enterprise-landing-zone-504409-backups" = [
    {
      role   = "roles/storage.objectAdmin"
      member = "serviceAccount:database-sa@enterprise-landing-zone-504409.iam.gserviceaccount.com"
    }
  ]
}

dns_zone_name = "enterprise-zone"

dns_name = "example.com."

dns_records = {
  root = {
    name    = "example.com."
    type    = "A"
    ttl     = 300
    rrdatas = ["1.1.1.1"]
  }

  www = {
    name    = "www.example.com."
    type    = "A"
    ttl     = 300
    rrdatas = ["1.1.1.1"]
  }
}