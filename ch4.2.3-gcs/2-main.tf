resource "google_storage_bucket" "gcs_ch4_2_3_bucket" {
  name     = var.gcs_name
  location = var.location
  # specify the storage class
  storage_class = "MULTI_REGIONAL"
  force_destroy = true

  public_access_prevention = "enforced"

  # Create the life cycle of objects in the bucket  
  lifecycle_rule {
    condition {
      # object equals to 90 days
      age = 90
    }
    action {
      # Delete the bucket  
      type = "Delete"
    }
  }
}
