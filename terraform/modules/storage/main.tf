resource "google_storage_bucket" "bucket" {

  for_each = var.buckets

  project       = var.project_id
  name          = each.key
  location      = each.value.location
  storage_class = each.value.storage_class

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  force_destroy = each.value.force_destroy

  versioning {
    enabled = each.value.enable_versioning
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = each.value.lifecycle_age
    }
  }

  labels = each.value.labels
}

resource "google_storage_bucket_iam_member" "bucket_members" {

  for_each = {
    for pair in flatten([
      for bucket_name, bindings in var.bucket_iam : [
        for binding in bindings : {
          key    = "${bucket_name}-${binding.role}-${binding.member}"
          bucket = bucket_name
          role   = binding.role
          member = binding.member
        }
      ]
    ]) : pair.key => pair
  }

  bucket = google_storage_bucket.bucket[each.value.bucket].name
  role   = each.value.role
  member = each.value.member
}