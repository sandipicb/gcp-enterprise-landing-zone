output "secret_ids" {
  description = "IDs of the Secret Manager secrets created by this module."

  value = {
    for k, secret in google_secret_manager_secret.secrets :
    k => secret.secret_id
  }
}