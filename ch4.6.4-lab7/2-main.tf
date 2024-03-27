# Create container resource
resource "google_cloud_run_service" "cloud_run_service_lab7" {
  name     = var.container_name_lab7
  location = var.gcp_region_lab7

  # image source and config
  template {
    spec {
      containers {
        image = var.image_name_lab7
        ports {
          # protocol to use outside
          name = "http1"

          # the port inside the container
          container_port = 8080
        }
      }
    }
  }

  # traffic direction
  traffic {
    percent         = 100
    latest_revision = true
  }

}

# config IAM for public access
resource "google_cloud_run_service_iam_member" "public_access_lab7" {
  location = google_cloud_run_service.cloud_run_service_lab7.location
  project  = google_cloud_run_service.cloud_run_service_lab7.project
  service  = google_cloud_run_service.cloud_run_service_lab7.name

  role   = "roles/run.invoker"
  member = "allUsers"

}

# output the cloud run url for accessibility
output "cloud_run_url_lab7" {
  value = google_cloud_run_service.cloud_run_service_lab7.status[0].url
}

