##### generate code to gcs
# 1. generate random id for bucket name
resource "random_id" "bucket_prefix" {
  byte_length = 8
}

# 2.Create gcs bucket to store code
resource "google_storage_bucket" "cloud_function_bucket" {
  # naiming the gcs using variable in the string
  name     = "${var.gcp_region}-bucket-${random_id.bucket_prefix.hex}"
  location = var.gcp_region
}

# 3. compress code as zip
data "archive_file" "src" {
  type = "zip"
  # ${path.root} ---> root path of terraform
  # source code
  source_dir = "${path.root}/src/"

  # output zip
  output_path = "${path.root}/generated/${var.func_name}.zip"

}

# 4. upload the object to gcs
resource "google_storage_bucket_object" "archive" {
  # naming the object in gcs
  name = "${data.archive_file.src.output_md5}.zip"
  # the bucket to store object
  bucket = google_storage_bucket.cloud_function_bucket.name
  # source of the object
  source = data.archive_file.src.output_path

  metadata = {
    Managedby = "Terraform"
  }

}

# create cloud function
resource "google_cloudfunctions_function" "hello_function" {
  name                = var.func_name
  description         = "A hello Cloud Function"
  runtime             = "python39"
  available_memory_mb = 256
  timeout             = 60
  region              = var.gcp_region

  # function source
  source_archive_bucket = google_storage_bucket.cloud_function_bucket.name
  source_archive_object = google_storage_bucket_object.archive.name

  trigger_http = true
  entry_point  = "handler"

  # indicates that cloud functions needs the following 2 resoruces to be created first
  depends_on = [
    google_storage_bucket.cloud_function_bucket,
    google_storage_bucket_object.archive
  ]
}

# Create IAM for public use
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.hello_function.project
  region         = google_cloudfunctions_function.hello_function.region
  cloud_function = google_cloudfunctions_function.hello_function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}