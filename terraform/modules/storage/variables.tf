variable "project_id" {
    type = string
}
variable "buckets" {
   description = "Storage of bucket configuration"

    type = map(object({
          location = string
          storage_class = string
          enable_versioning = bool
          lifecycle_age = number
          force_destroy = bool
          labels = map(string)
     }))
}
variable "location" {
    type = string
    default = "US"
}
variable "storage_class" {
    type = string
    default = "STANDARD"
}
variable "enable_versioning" {
    type = bool
    default = true
}
variable "labels" {
    type = map(string)
    default = {}
}

variable "bucket_iam" {
  description = "Bucket IAM assignments"

  type = map(list(object({
    role   = string
    member = string
  })))

  default = {}
}

