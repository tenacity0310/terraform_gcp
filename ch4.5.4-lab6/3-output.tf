output "bucket_name_lab6" {
  value = google_storage_bucket.cloud_function_bucket_lab6.name
}

output "cloud_function_lab6_https_trigger_ul" {
  value = google_cloudfunctions_function.pong_function.https_trigger_url
}