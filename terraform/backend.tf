terraform {
    backend "gcs"{
        bucket = "gcp-elz-123-tfstate"
        prefix = "terraform/state"
    }
}