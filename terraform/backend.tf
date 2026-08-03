terraform {
  backend "gcs" {
    bucket = "enterprise-landing-zone-504409-tfstate"
    prefix = "terraform/state"
  }
}