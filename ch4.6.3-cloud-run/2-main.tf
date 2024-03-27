# Create container resource
resource "google_cloud_run_service" "cloud_run_service" {
  name     = var.container_name
  location = var.gcp_region

  # image source and config
  template {
    spec {
      containers {
        image = "nginx:1.23.4-alpine"
        ports {
          # protocol to use outside
          name = "http1"

          # the port inside the container
          container_port = 80
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
resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_service.cloud_run_service.location
  project  = google_cloud_run_service.cloud_run_service.project
  service  = google_cloud_run_service.cloud_run_service.name

  role   = "roles/run.invoker"
  member = "allUsers"

}

# output the cloud run url for accessibility
output "cloud_run_url" {
  value = google_cloud_run_service.cloud_run_service.status[0].url
}

