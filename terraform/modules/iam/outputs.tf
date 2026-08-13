output "service_accounts" {
  description = "Email addresses of the service accounts created by this module."

  value = {
    for k, sa in google_service_account.service_accounts :
    k => sa.email
  }
}