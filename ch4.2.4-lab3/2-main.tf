resource "google_storage_bucket" "gcs_tf_lab03" {
  name          = var.gcs_name
  location      = var.location
  force_destroy = true
  # choose storage that is only in one region
  storage_class = "REGIONAL"
  # prevent public access
  public_access_prevention = "enforced"

  # The period of time, in seconds, that objects in the bucket must be retained and cannot be deleted, overwritten, or archived.
  retention_policy {
    # 3600 secs(1hr)* 24(hrs)*30(days) ---> seconds for 30 days
    retention_period = 3600 * 24 * 30
  }

  # set lifecycle for objects in the bucket
  lifecycle_rule {
    condition {
      # 90 days
      age = 90
    }
    action {
      # delete after 90 days
      type = "Delete"
    }
  }
}
