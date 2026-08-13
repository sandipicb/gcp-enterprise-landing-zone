variable "network_name" {
  description = "VPC network name."
  type        = string
}

variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "subnets" {
  description = "List of subnets."
  type = list(object({
    name                     = string
    cidr                     = string
    region                   = string
    private_ip_google_access = bool
  }))
}