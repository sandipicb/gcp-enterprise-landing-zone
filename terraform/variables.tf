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

variable "storage_buckets" {
  type = map(object({
    location          = string
    storage_class     = string
    enable_versioning = bool
    lifecycle_age     = number
    force_destroy     = bool
    labels            = map(string)
  }))
}

variable "bucket_iam" {
  description = "Bucket IAM assignments"

  type = map(list(object({
    role   = string
    member = string
  })))

  default = {}
}