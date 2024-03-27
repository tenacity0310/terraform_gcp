##### generate code to gcs
# 1. generate random id for bucket name
resource "random_id" "bucket_prefix_lab6" {
  byte_length = 8
}

# 2.Create gcs bucket to store code
resource "google_storage_bucket" "cloud_function_bucket_lab6" {
  # naiming the gcs using variable in the string
  name     = "${var.gcp_region_lab6}-bucket-${random_id.bucket_prefix_lab6.hex}"
  location = "ASIA"
}

# 3. compress code as zip
data "archive_file" "src_lab6" {
  type = "zip"
  # ${path.root} ---> root path of terraform
  # source code
  source_dir = "${path.root}/src/"

  # output zip
  output_path = "${path.root}/generated/${var.func_name_lab6}.zip"

}

# 4. upload the object to gcs
resource "google_storage_bucket_object" "archive_lab6" {
  # naming the object in gcs
  name = "${data.archive_file.src_lab6.output_md5}.zip"
  # the bucket to store object
  bucket = google_storage_bucket.cloud_function_bucket_lab6.name
  # source of the object
  source = data.archive_file.src_lab6.output_path

  metadata = {
    Managedby = "Terraform"
  }

}

# create cloud function
resource "google_cloudfunctions_function" "pong_function" {
  name                = var.func_name_lab6
  description         = "A pong Function"
  runtime             = "python39"
  available_memory_mb = 256
  timeout             = 60
  region              = var.gcp_region_lab6

  # function source
  source_archive_bucket = google_storage_bucket.cloud_function_bucket_lab6.name
  source_archive_object = google_storage_bucket_object.archive_lab6.name

  trigger_http = true
  # set the entry point as the "ping" function
  entry_point = "ping"

  # indicates that cloud functions needs the following 2 resoruces to be created first
  depends_on = [
    google_storage_bucket.cloud_function_bucket_lab6,
    google_storage_bucket_object.archive_lab6
  ]
}

# Create IAM for public use
resource "google_cloudfunctions_function_iam_member" "invoker_lab6" {
  project        = google_cloudfunctions_function.pong_function.project
  region         = google_cloudfunctions_function.pong_function.region
  cloud_function = google_cloudfunctions_function.pong_function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}