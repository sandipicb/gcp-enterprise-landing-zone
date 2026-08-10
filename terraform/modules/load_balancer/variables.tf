variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone"
  type        = string
}

variable "network_name" {
  description = "VPC network name"
  type        = string
}

variable "global_ip_address" {
  description = "Existing reserved global IP address"
  type        = string
}

variable "backend_instance" {
  description = "Backend VM name"
  type        = string
}

variable "backend_zone" {
  description = " Backend VM zone"
  type        = string
}

variable "domain" {
  description = "Domain name for the Google-managed SSL certificate"
  type        = string
}