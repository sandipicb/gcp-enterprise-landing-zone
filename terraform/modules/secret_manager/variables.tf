variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "secrets" {
  description = "List of secrets"

  type = list(object({
    secret_id = string
    value     = string
  }))
}

variable "secret_accessors" {
  description = "Map of secret IDs to service accounts allowed to access them"

  type = map(list(string))
}