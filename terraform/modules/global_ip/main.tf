resource "google_compute_global_address" "address" {
  for_each = var.addresses

  project = var.project_id

  name        = each.key
  description = each.value.description
  ip_version  = each.value.ip_version
}