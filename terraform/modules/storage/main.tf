resource "google_storage_bucket" "bucket" {
    project = var.project_id
    name = var.bucket_name
    location = var.location
    storage_class = var.storage_class

    uniform_bucket_level_access = true
    versioning {
        enabled = var.enable_versioning
    }
    lifecycle_rule {
        action {
            type = "Delete"
        }
        condition {
            age = 90
        }
    }

    labels = var.labels
}