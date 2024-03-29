# use this data source to access the configuration of the Google Cloud Provider
data "google_client_config" "default" {}

# fetch the serivce account that is currently used for gke 
data "google_comput_default_service_account" "default" {}

module "gke" {
  # refernce to the external module
  source     = "terraform-google-modules/kubernetes-engine/google"
  region     = var.gcp_region
  project_id = var.GCP_PROJECT
  name       = var.cluster_name
  zones      = ["asia-northeast1-a"]

  # VPC
  network = "default"
  subnetwork = "deafault"

  # self-defining the ip range
  # asia-northeast1-pods-03263bcb	    10.14.0.0/20
  # asia-northeast1-services-03263bcb	10.18.0.0/20
  ip_range_pods = 

}
