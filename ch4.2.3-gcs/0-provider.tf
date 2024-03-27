terraform {
  # specify version  of terraform 
  required_version = ">=1.7.0"
  required_providers {
    google = {
      source = "hashicorp/google"
      # specify version of google provider version
      version = ">=5.15.0"
    }
  }
}

provider "google" {
  project = var.GCP_PROJECT
}
