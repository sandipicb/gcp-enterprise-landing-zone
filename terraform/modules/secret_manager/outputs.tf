output "secret_ids"{
    value = {
        for k, secret in google_secret_manager_secret.secrets :
        k => secret.secret_id
    }
}