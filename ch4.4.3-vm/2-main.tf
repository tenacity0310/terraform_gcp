# Create new instance
resource "google_compute_instance" "example" {
  name         = var.instance_name
  zone         = var.zone
  machine_type = "e2-medium"

  # disk for booting and OS  
  boot_disk {
    initialize_params {
      # use gcloud compute images list to search for the image source
      image = "debian-cloud/debian-10"
    }
  }
  # choose the vpc network
  network_interface {
    network = "default"

    # accessible public ip
    access_config {
    }
  }

}

# render the output of the ip
output "instance_ip" {
  # network_interface[0]: the first network_interface
  # access_config[0]: the first access_config
  value = google_compute_instance.example.network_interface[0].access_config[0].nat_ip
}