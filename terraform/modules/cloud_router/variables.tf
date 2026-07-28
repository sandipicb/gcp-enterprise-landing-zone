variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Region where the Cloud Router will be created"
  type        = string
}

variable "network_name" {
  description = "VPC network name"
  type        = string
}

variable "router_name" {
  description = "Cloud Router name"
  type        = string
  default     = "enterprise-router"
}