variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "service_accounts" {
  description = "List of service accounts"

  type = list(object({
    account_id   = string
    display_name = string
    })
  )
}

variable "iam_bindings" {
  description = "IAM role bindings"

  type = map(list(string))
}
