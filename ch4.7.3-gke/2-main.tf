# use this data source to access the configuration of the Google Cloud Provider
data "google_client_config" "default" {}

# fetch the serivce account that is currently used for gke 
data "google_compute_default_service_account" "default" {}

module "gke" {
  # refernce to the external module
  source     = "terraform-google-modules/kubernetes-engine/google"
  region     = var.gcp_region
  project_id = var.GCP_PROJECT
  name       = var.cluster_name
  zones      = ["asia-northeast1-a"]

  # VPC
  network    = "default"
  subnetwork = "default"

  # asia-northeast1-pods-03263bcb  = 10.14.0.0/20
  # asia-northeast1-services-03263bcb = 10.18.0.0/20
  ip_range_pods     = "asia-northeast1-pods-03263bcb"
  ip_range_services = "asia-northeast1-services-03263bcb"

  create_service_account = false
  service_account        = data.google_compute_default_service_account.default.email

  # use spot pool
  remove_default_node_pool = true
  http_load_balancing      = true
  gce_pd_csi_driver        = true
  filestore_csi_driver     = false
  kubernetes_version       = "1.27.8-gke.1067004"

  node_pools = [
    {
      name               = "spot-worker-pool"
      machine_type       = "e2-medium"
      min_count          = 0
      max_count          = 3
      spot               = true
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      enable_gvnic       = false
      auto_repair        = true
      initial_node_count = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  node_pools_labels = {
    all = {}

    spot-worker-pool = {
      spot-worker-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    spot-worker-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    spot-worker-pool = [
      {
        key    = "spot-worker-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    spot-worker-pool = [
      "spot-worker-pool",
    ]
  }

}
