variable "project_id" {
    type = string
}
variable "bucket_name" {
    type = string
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


