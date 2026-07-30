resource "google_service_account" "service_accounts" {
  for_each = {
    for sa in var.service_accounts :
    sa.account_id => sa
  }

  account_id   = each.value.account_id
  display_name = each.value.display_name

  project = var.project_id
}

resource "google_project_iam_member" "bindings" {

  for_each = {
    for pair in flatten([
      for role, members in var.iam_bindings : [
        for member in members : {
          role   = role
          member = member
          key    = "${role}-${member}"
        }
      ]
    ]) :
    pair.key => pair
  }

  project = var.project_id
  role    = each.value.role
  member  = each.value.member
}