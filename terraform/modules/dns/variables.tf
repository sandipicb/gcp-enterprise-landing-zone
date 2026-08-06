variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "zone_name" {
  description = "Cloud DNS Managed zone name"
  type        = string
}

variable "dns_name" {
  description = "DNS Name (must end with a dot)"
  type        = string
  default     = "Managed by Terraform"
}

variable "description" {
  description = "Managed Zone Description"
  type        = string
  default     = "Managed by Terraform"
}

variable "visibility" {
  description = "DNS Visibility"
  type        = string
  default     = "public"
}

variable "records" {
  description = "DNS Records"

  type = map(object({
    name    = string
    type    = string
    ttl     = number
    rrdatas = list(string)
  }))

  default = {}
}