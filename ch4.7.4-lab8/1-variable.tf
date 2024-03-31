variable "GCP_PROJECT" {
  description = "GCP Project ID"
  type        = string
  default     = "terrafrom101-2024"
}

variable "gcp_region" {
  type    = string
  default = "asia-northeast1"
}

# name of the function
variable "cluster_name" {
  type    = string
  default = "gke-tf-ch4-lab8"
}

