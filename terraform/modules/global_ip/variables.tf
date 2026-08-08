variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "addresses" {
  description = "Global static IP addresses"

  type = map(object({
    description = string
    ip_version  = string
  }))
}