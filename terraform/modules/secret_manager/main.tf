resource "google_secret_manager_secret" "secrets" {

  for_each = {
    for secret in var.secrets :
    secret.secret_id => secret
  }

  project   = var.project_id
  secret_id = each.value.secret_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "versions" {

  for_each = google_secret_manager_secret.secrets

  secret = each.value.id

  secret_data = var.secrets[
    index(
      [for s in var.secrets : s.secret_id],
      each.key
    )
  ].value
}

resource "google_secret_manager_secret_iam_member" "accessors" {
    for_each = {
        for pair in flatten([
            for secret, member in   var.secret_accessors : [
                for member in member : {
                    secret = secret
                    member    = member
                    key      = "${secret}-${member}"
                }
            ]
        ]):
        pair.key => pair
    }
    project = var.project_id    

    secret_id = google_secret_manager_secret.secrets[each.value.secret].secret_id
    role      = "roles/secretmanager.secretAccessor"
    member    = each.value.member   
}

    