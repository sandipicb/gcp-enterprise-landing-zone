resource "google_dns_managed_zone" "zone" {
  name        = var.project_id
  dns_name    = var.dns_name
  description = var.description
  visibility  = var.visibility
}

resource "google_dns_record_set" "records" {
  for_each = var.records

  project      = var.project_id
  managed_zone = google_dns_managed_zone.zone.name

  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  rrdatas = each.value.rrdatas
}