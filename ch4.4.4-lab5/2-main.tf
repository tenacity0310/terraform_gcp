# Create GCE VM
resource "google_compute_instance" "example" {
  name         = var.instance_name
  zone         = var.zone
  machine_type = "e2-medium"

  # OS disk : debian-based
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  # The network to attach
  network_interface {
    network = "default"
    # external ip config
    access_config {
    }
  }

  # bootstrap with ngnix installed
  
  metadata_startup_script = "sudo apt update -y && sudo apt install nginx -y"

}

# Create 2nd Disk
resource "google_compute_region_disk" "example" {
  name   = "example-disk"
  type   = "pd-standard"
  region = var.location
  size   = 200

  replica_zones = ["asia-northeast1-a", "asia-northeast1-b"]
}

# attach disk
resource "google_compute_attached_disk" "example" {
  disk     = google_compute_region_disk.example.self_link
  instance = google_compute_instance.example.self_link
  mode     = "READ_WRITE"
}

output "instance_ip" {
  value = google_compute_instance.example.network_interface[0].access_config[0].nat_ip
}