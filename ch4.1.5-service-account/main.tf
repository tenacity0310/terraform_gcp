provider "google" {
  # specify the credentials, the file is created on GCP for service account key
  # file() function will take value from `tf101-sa.json` in the folder.
  credentials = file("tf101-sa.json")
  project     = "terrafrom101-2024"
  region      = "asia-east1"

}
resource "google_storage_bucket" "quick-start-gcs" {
  name          = "quick-start-gcs-bucket"
  location      = "asia-east1"
  force_destroy = true
}
