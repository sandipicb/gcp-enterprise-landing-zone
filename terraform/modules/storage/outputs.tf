output "bucket_names" {
  description = "Names of all storage buckets"  

  value = {
    for name, bucket in google_storage_bucket.bucket : 
    name => bucket.name
  }
}

output "bucket_urls"{
  description = "URLs of all storage buckets"
  value = {
    for name, bucket in google_storage_bucket.bucket : 
    name => bucket.url
  }
}
output "bucket_self_link" {
  description = "Self links of all storage buckets"
  value = {
    for name, bucket in google_storage_bucket.bucket : 
    name => bucket.self_link
  }
}

output "bucket_iam_members" {
  description = "Bucket IAM members"

  value = {
    for key, member in google_storage_bucket_iam_member.bucket_members :
    key => {
      bucket = member.bucket
      role   = member.role
      member = member.member
    }
  }
}