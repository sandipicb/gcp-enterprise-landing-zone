variable "project_id" {
  description = "Google Cloud project ID."
  type = string
}

variable "zone" {
  type = string
}

variable "network_name" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "public_ip" {
  type    = bool
  default = false
}

variable "service_account_email" {
  description = "Service Account attached to the VM"
  type        = string
}