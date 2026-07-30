output "service_accounts" {
  value = {
    for k, sa in google_service_account.service_accounts :
    k => sa.email
  }
}