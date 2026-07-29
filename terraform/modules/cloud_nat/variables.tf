variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
}

variable "router_name" {
  description = "Cloud Router name"
  type        = string
}

variable "nat_name" {
  description = "Cloud NAT name"
  type        = string
  default     = "enterprise-nat"
}