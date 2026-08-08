output "addresses" {
  description = "Reserved global IP addresses"

  value = {
    for name, address in google_compute_global_address.address :
    name => address.address
  }
}

output "self_link" {
  description = "Self_links of global IP addresses"

  value = {
    for name, address in google_compute_global_address.address :
    name => address.self_link
  }

}
