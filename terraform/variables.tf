variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "network_name" {
  description = "VPC network name"
  type        = string
}

variable "zone" {
  description = "Google Cloud zone"
  type        = string
  default     = "us-central1-a"
}

variable "router_name" {
  description = "Cloud Router name"
  type        = string
  default     = "enterprise-router"
}

variable "nat_name" {
  description = "Cloud NAT name"
  type        = string
  default     = "enterprise-nat"
}

variable "storage_bucket_name" {
  type = string
}

