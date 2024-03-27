# Create the vpc networking
resource "google_compute_network" "custom_network" {
  name = var.network_name
  # disable automatic subnet creation
  auto_create_subnetworks = false
}

# Create subnet in japan
resource "google_compute_subnetwork" "japan_subnet" {
  name = "japan-subnet"
  # reference to the vpc
  network       = google_compute_network.custom_network.self_link
  ip_cidr_range = "10.0.0.0/24"
  region        = "asia-northeast1"
}

# Create subnet in singapore
resource "google_compute_subnetwork" "singapore_subnet" {
  name = "singapore-subnet"
  # reference to the vpc
  network       = google_compute_network.custom_network.self_link
  ip_cidr_range = "10.1.0.0/24"
  region        = "asia-southeast1"
}

# set firewall
resource "google_compute_firewall" "ssh_https_firewall" {
  name = "ssh-https-firewall"
  # reference to the vpc
  network = google_compute_network.custom_network.self_link

  # allowed protocols and ports  
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]

}
