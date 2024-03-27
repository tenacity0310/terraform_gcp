variable "GCP_PROJECT" {
  description = "GCP Project ID"
  type        = string
  default     = "terrafrom101-2024"
}

variable "gcp_region_lab7" {
  type    = string
  default = "asia-northeast1"
}

# name of the function
variable "container_name_lab7" {
  type    = string
  default = "cloud-run-ch4-lab7"
}

variable "image_name_lab7" {
  type    = string
  default = "asia-east1-docker.pkg.dev/terrafrom101-2024/terraform-practice/cloud-run-tf-ch4-lab-7"
}